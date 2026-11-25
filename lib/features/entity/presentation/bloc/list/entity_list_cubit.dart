import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/network/load_exception.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

import 'entity_list_state.dart';

class EntityListCubit extends Cubit<EntityListState> {
  EntityListCubit(this._repository) : super(const EntityListState());

  final IEntityRepository _repository;
  Timer? _debounce;
  int _generation = 0;

  Future<void> load() {
    _debounce?.cancel();
    emit(EntityListState(query: state.query));
    return _fetch(++_generation);
  }

  void search(String query) {
    _debounce?.cancel();
    final generation = ++_generation;
    emit(EntityListState(query: query));
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => _fetch(generation),
    );
  }

  Future<void> loadMore() async {
    if (state.next == null ||
        (state.status != ListStatus.ready &&
            state.status != ListStatus.moreFailed)) {
      return;
    }
    emit(state.withStatus(ListStatus.loadingMore));
    await _fetch(_generation);
  }

  Future<void> _fetch(int generation) async {
    final previous = state;
    try {
      final page = await _repository.getPage(
        query: previous.query.trim(),
        offset: previous.next ?? 0,
      );
      if (isClosed || generation != _generation) return;
      final known = previous.items.map((item) => item.id).toSet();
      final added = page.items.where((item) => known.add(item.id)).toList();
      final labels = await _repository.getLabels(
        added
            .map((item) => item.typeId)
            .nonNulls
            .where((id) => !previous.labels.containsKey(id)),
      );
      if (isClosed || generation != _generation) return;
      emit(
        EntityListState(
          status: ListStatus.ready,
          query: previous.query,
          items: [...previous.items, ...added],
          labels: {...previous.labels, ...labels},
          next: page.next,
        ),
      );
    } on LoadException {
      if (isClosed || generation != _generation) return;
      emit(
        previous.withStatus(
          previous.next == null ? ListStatus.failed : ListStatus.moreFailed,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

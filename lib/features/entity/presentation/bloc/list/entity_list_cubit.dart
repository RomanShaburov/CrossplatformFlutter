import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_state.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

class EntityListCubit extends Cubit<EntityListState> {
  EntityListCubit(this._repository) : super(const EntityListState());

  final IEntityRepository _repository;

  Future<void> load() async {
    final items = await _repository.getEntities();
    final labels = await _typeLabels(items);
    if (isClosed) return;
    emit(state.copyWith(items: items, labels: labels));
  }

  Future<void> search(String query) async {
    emit(state.copyWith(query: query));
    final items = await _repository.searchEntities(query);
    final labels = await _typeLabels(items);
    if (isClosed || state.query != query) return;
    emit(state.copyWith(items: items, labels: {...state.labels, ...labels}));
  }

  Future<Map<String, String>> _typeLabels(List<EntityModel> items) =>
      _repository.getLabels(items.map((entity) => entity.typeId).nonNulls);
}

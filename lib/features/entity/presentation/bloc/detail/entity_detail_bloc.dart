import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/detail/entity_detail_event.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/detail/entity_detail_state.dart';

class EntityDetailBloc extends Bloc<EntityDetailEvent, EntityDetailState> {
  EntityDetailBloc(this._repository) : super(const EntityDetailLoading()) {
    on<EntityDetailOpened>(_onOpened);
  }

  final IEntityRepository _repository;

  Future<void> _onOpened(
    EntityDetailOpened event,
    Emitter<EntityDetailState> emit,
  ) async {
    final entity = await _repository.getEntity(event.id);
    if (entity == null) {
      emit(EntityDetailNotFound(event.id));
      return;
    }
    final referenced = [
      for (final values in entity.claims.values)
        for (final value in values)
          if (value case EntityRef(:final id)) id,
    ];
    final labels = await _repository.getLabels(referenced);
    emit(EntityDetailLoaded(entity, labels: labels));
  }
}

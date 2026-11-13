import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';

sealed class EntityDetailState {
  const EntityDetailState();
}

final class EntityDetailLoading extends EntityDetailState {
  const EntityDetailLoading();
}

final class EntityDetailLoaded extends EntityDetailState {
  const EntityDetailLoaded(this.entity, {required this.labels});

  final EntityModel entity;
  final Map<String, String> labels;
}

final class EntityDetailNotFound extends EntityDetailState {
  const EntityDetailNotFound(this.id);

  final String id;
}

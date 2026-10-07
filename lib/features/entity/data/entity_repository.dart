import 'package:wikidata_catalog/features/entity/data/mock_entities.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';

final class EntityRepository implements IEntityRepository {
  const EntityRepository();

  @override
  Future<List<EntityModel>> getEntities() async => mockEntities;

  @override
  Future<EntityModel?> getEntity(String id) async {
    for (final entity in mockEntities) {
      if (entity.id == id) return entity;
    }
    return null;
  }

  @override
  Future<Map<String, String>> getLabels(Iterable<String> ids) async {
    final wanted = ids.toSet();
    return {
      for (final entity in mockEntities)
        if (wanted.contains(entity.id)) entity.id: entity.label,
    };
  }
}

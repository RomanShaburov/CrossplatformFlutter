import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';

abstract interface class IEntityRepository {
  Future<List<EntityModel>> getEntities();

  Future<EntityModel?> getEntity(String id);

  Future<List<EntityModel>> searchEntities(String query);

  Future<Map<String, String>> getLabels(Iterable<String> ids);
}

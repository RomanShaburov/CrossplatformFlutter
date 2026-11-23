import 'entity_model.dart';

typedef EntityPage = ({List<EntityModel> items, int? next});

abstract interface class IEntityRepository {
  Future<EntityPage> getPage({required String query, required int offset});
  Future<EntityModel?> getEntity(String id);
  Future<Map<String, String>> getLabels(Iterable<String> ids);
}

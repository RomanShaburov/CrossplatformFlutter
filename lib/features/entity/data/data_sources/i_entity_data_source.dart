import '../dto/entity_dto.dart';

abstract interface class IEntityDataSource {
  Future<SearchDto> search(String query, int offset, int limit);
  Future<EntitiesDto> entities(List<String> ids, String properties);
}

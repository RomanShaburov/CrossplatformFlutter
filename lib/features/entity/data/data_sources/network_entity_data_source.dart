import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wikidata_catalog/common/network/load_exception.dart';

import '../api/entity_api.dart';
import '../dto/entity_dto.dart';
import 'i_entity_data_source.dart';

final class NetworkEntityDataSource implements IEntityDataSource {
  const NetworkEntityDataSource(this._api);
  final EntityApi _api;

  @override
  Future<SearchDto> search(String query, int offset, int limit) =>
      _load(() => _api.search(query, offset, limit));

  @override
  Future<EntitiesDto> entities(List<String> ids, String properties) =>
      _load(() => _api.entities(ids, properties));

  Future<T> _load<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException {
      throw const NetworkLoadException();
    } on FormatException {
      throw const ResponseLoadException();
    } on CheckedFromJsonException {
      throw const ResponseLoadException();
    }
  }
}

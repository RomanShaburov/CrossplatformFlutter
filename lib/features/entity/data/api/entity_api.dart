import 'package:dio/dio.dart';

import '../dto/entity_dto.dart';

final class EntityApi {
  const EntityApi(this._dio);
  final Dio _dio;

  Future<SearchDto> search(String query, int offset, int limit) async {
    final language = RegExp(r'[А-Яа-яЁё]').hasMatch(query) ? 'ru' : 'en';
    return SearchDto.fromJson(
      await _request({
        'action': 'wbsearchentities',
        'search': query,
        'type': 'item',
        'language': language,
        'limit': limit,
        'continue': offset,
      }),
    );
  }

  Future<EntitiesDto> entities(List<String> ids, String properties) async {
    return EntitiesDto.fromJson(
      await _request({
        'action': 'wbgetentities',
        'ids': ids.join('|'),
        'props': properties,
        'languages': 'ru|en',
        'sitefilter': 'ruwiki|enwiki',
      }),
    );
  }

  Future<Map<String, dynamic>> _request(Map<String, Object> parameters) async {
    final response = await _dio.get<Object?>(
      '/w/api.php',
      queryParameters: parameters,
    );
    final body = response.data;
    if (body is! Map<String, dynamic> || body.containsKey('error')) {
      throw const FormatException('Invalid Wikidata response');
    }
    return body;
  }
}

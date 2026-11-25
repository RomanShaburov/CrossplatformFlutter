import '../domain/entity_model.dart';
import '../domain/i_entity_repository.dart';
import 'data_sources/i_entity_data_source.dart';
import 'mappers/entity_mapper.dart';

final class EntityRepository implements IEntityRepository {
  const EntityRepository(this._source);
  final IEntityDataSource _source;

  // The editorial selection from lab 2. Titles, types and descriptions come from Wikidata.
  static const _featuredIds = [
    'Q42',
    'Q80',
    'Q937',
    'Q7186',
    'Q935',
    'Q7259',
    'Q762',
    'Q12418',
    'Q19675',
    'Q243',
    'Q90',
    'Q142',
    'Q84',
    'Q145',
    'Q64',
    'Q183',
    'Q2',
    'Q5',
    'Q3624078',
    'Q5119',
  ];
  static const _pageSize = 8;

  @override
  Future<EntityPage> getPage({
    required String query,
    required int offset,
  }) async {
    final List<String> ids;
    final int? next;
    if (query.isEmpty) {
      ids = _featuredIds.skip(offset).take(_pageSize).toList();
      final end = offset + ids.length;
      next = end < _featuredIds.length ? end : null;
    } else {
      final results = await _source.search(query, offset, _pageSize);
      ids = results.search.map((hit) => hit.id).toList();
      next = results.next;
    }
    if (ids.isEmpty) return (items: <EntityModel>[], next: next);
    final response = await _source.entities(ids, 'labels|descriptions|claims');
    return (
      items: [
        for (final id in ids)
          if (response.entities[id] case final entity?
              when entity.missing == null)
            entity.toModel(),
      ],
      next: next,
    );
  }

  @override
  Future<EntityModel?> getEntity(String id) async {
    if (!RegExp(r'^Q[1-9]\d*$').hasMatch(id)) return null;
    final response = await _source.entities([
      id,
    ], 'labels|descriptions|aliases|claims|sitelinks');
    final entity = response.entities[id];
    return entity == null || entity.missing != null
        ? null
        : entity.toModel(detail: true);
  }

  @override
  Future<Map<String, String>> getLabels(Iterable<String> ids) async {
    final unique = ids.toSet().toList();
    const batchSize = 25;
    final batches = await Future.wait([
      for (var i = 0; i < unique.length; i += batchSize)
        _source.entities(unique.skip(i).take(batchSize).toList(), 'labels'),
    ]);
    return {
      for (final batch in batches)
        for (final entity in batch.entities.values)
          if (entity.missing == null) entity.id: entity.label,
    };
  }
}

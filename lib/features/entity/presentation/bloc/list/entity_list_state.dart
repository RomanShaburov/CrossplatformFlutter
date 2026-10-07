import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

final class EntityListState {
  const EntityListState({
    this.query = '',
    this.items = const [],
    this.labels = const {},
  });

  final String query;
  final List<EntityModel> items;
  final Map<String, String> labels;

  bool get nothingFound => items.isEmpty && query.trim().isNotEmpty;

  String? typeLabelOf(EntityModel entity) {
    final typeId = entity.typeId;
    return typeId == null ? null : labels[typeId] ?? typeId;
  }

  EntityListState copyWith({
    String? query,
    List<EntityModel>? items,
    Map<String, String>? labels,
  }) => EntityListState(
    query: query ?? this.query,
    items: items ?? this.items,
    labels: labels ?? this.labels,
  );
}

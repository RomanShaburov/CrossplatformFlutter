import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

final class EntityListState {
  const EntityListState({this.items = const [], this.labels = const {}});

  final List<EntityModel> items;
  final Map<String, String> labels;

  String? typeLabelOf(EntityModel entity) {
    final typeId = entity.typeId;
    return typeId == null ? null : labels[typeId] ?? typeId;
  }

  EntityListState copyWith({
    List<EntityModel>? items,
    Map<String, String>? labels,
  }) => EntityListState(
    items: items ?? this.items,
    labels: labels ?? this.labels,
  );
}

import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

enum ListStatus { loading, ready, failed, loadingMore, moreFailed }

final class EntityListState {
  const EntityListState({
    this.status = ListStatus.loading,
    this.query = '',
    this.items = const [],
    this.labels = const {},
    this.next,
  });

  final ListStatus status;
  final String query;
  final List<EntityModel> items;
  final Map<String, String> labels;
  final int? next;

  EntityListState withStatus(ListStatus value) => EntityListState(
    query: query,
    items: items,
    labels: labels,
    next: next,
    status: value,
  );

  bool get nothingFound => items.isEmpty && query.trim().isNotEmpty;

  String? typeLabelOf(EntityModel entity) {
    final typeId = entity.typeId;
    return typeId == null ? null : labels[typeId] ?? typeId;
  }
}

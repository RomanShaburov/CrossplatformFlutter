import 'package:flutter/material.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';

const String instanceOf = 'P31';

extension EntityFormat on EntityModel {
  String? get typeId => switch (claims[instanceOf]?.firstOrNull) {
    EntityRef(:final id) => id,
    _ => null,
  };

  IconData get placeholderIcon => switch (typeId) {
    'Q5' => Icons.person,
    'Q3624078' => Icons.flag,
    'Q5119' || 'Q515' => Icons.location_city,
    'Q3305213' => Icons.palette,
    'Q33506' => Icons.museum,
    'Q12518' => Icons.cell_tower,
    'Q634' => Icons.public,
    _ => Icons.category,
  };
}

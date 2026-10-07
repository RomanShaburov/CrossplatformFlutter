import 'package:flutter/material.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/entity_format.dart';

class EntityPlaceholder extends StatelessWidget {
  const EntityPlaceholder({super.key, required this.entity, this.size = 56});

  final EntityModel entity;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        entity.placeholderIcon,
        size: size / 2,
        color: colors.onPrimaryContainer,
      ),
    );
  }
}

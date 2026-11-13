import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wikidata_catalog/common/navigation/app_router.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/presentation/utils/claim_format.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class ClaimRow extends StatelessWidget {
  const ClaimRow({
    super.key,
    required this.propertyId,
    required this.values,
    required this.labels,
  });

  final String propertyId;
  final List<ClaimValue> values;
  final Map<String, String> labels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          AppLocalizations.of(context).property(propertyId),
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final value in values)
              switch (value) {
                EntityRef(:final id) when labels.containsKey(id) => ActionChip(
                  label: Text(labels[id]!),
                  onPressed: () => context.push(AppRoutes.detail(id)),
                ),
                EntityRef(:final id) => _PlainValue(id),
                DateValue() => _PlainValue(value.display(locale)),
                QuantityValue() => _PlainValue(value.display(locale)),
                TextValue(:final text) => _PlainValue(text),
              },
          ],
        ),
      ],
    );
  }
}

class _PlainValue extends StatelessWidget {
  const _PlainValue(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyLarge);
  }
}

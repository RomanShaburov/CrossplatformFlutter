import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/widgets/app_scaffold.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/detail/entity_detail_bloc.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/detail/entity_detail_event.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/detail/entity_detail_state.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/claim_row.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/entity_placeholder.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/section.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class EntityDetailScreen extends StatelessWidget {
  const EntityDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EntityDetailBloc(context.read<IEntityRepository>())
            ..add(EntityDetailOpened(id)),
      child: AppScaffold(
        title: AppLocalizations.of(context).detailTitle,
        body: BlocBuilder<EntityDetailBloc, EntityDetailState>(
          builder: (context, state) => switch (state) {
            EntityDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            EntityDetailNotFound(:final id) => Center(
              child: Text(AppLocalizations.of(context).detailNotFound(id)),
            ),
            EntityDetailLoaded(:final entity, :final labels) => _DetailContent(
              entity: entity,
              labels: labels,
            ),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.entity, required this.labels});

  final EntityModel entity;
  final Map<String, String> labels;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Row(
                spacing: 16,
                children: [
                  EntityPlaceholder(entity: entity, size: 72),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          entity.label,
                          style: theme.textTheme.headlineMedium,
                        ),
                        Text(
                          entity.id,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(entity.description, style: theme.textTheme.bodyLarge),
              if (entity.aliases.isNotEmpty)
                Section(
                  title: l10n.sectionAliases,
                  child: Text(
                    entity.aliases.join(', '),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              if (entity.claims.isNotEmpty)
                Section(
                  title: l10n.sectionProperties,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      for (final MapEntry(:key, :value)
                          in entity.claims.entries)
                        ClaimRow(
                          propertyId: key,
                          values: value,
                          labels: labels,
                        ),
                    ],
                  ),
                ),
              if (entity.wikipediaTitle case final title?)
                Section(
                  title: l10n.sectionWikipedia,
                  child: Text(title, style: theme.textTheme.bodyLarge),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

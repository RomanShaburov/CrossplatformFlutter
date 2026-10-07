import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wikidata_catalog/common/navigation/app_router.dart';
import 'package:wikidata_catalog/common/widgets/app_scaffold.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_cubit.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_state.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/entity_card.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/search_field.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class EntityListScreen extends StatelessWidget {
  const EntityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EntityListCubit>();
    return AppScaffold(
      title: AppLocalizations.of(context).appTitle,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(
              initialQuery: cubit.state.query,
              onChanged: cubit.search,
            ),
          ),
          Expanded(
            child: BlocBuilder<EntityListCubit, EntityListState>(
              builder: (context, state) => state.nothingFound
                  ? _NothingFound(query: state.query)
                  : ListView.separated(
                      key: const PageStorageKey('entity-list'),
                      padding: const EdgeInsets.all(16),
                      itemCount: state.items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final entity = state.items[index];
                        return EntityCard(
                          entity: entity,
                          typeLabel: state.typeLabelOf(entity),
                          onTap: () =>
                              context.push(AppRoutes.detail(entity.id)),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NothingFound extends StatelessWidget {
  const _NothingFound({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            Text(
              AppLocalizations.of(context).searchNothingFound(query),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

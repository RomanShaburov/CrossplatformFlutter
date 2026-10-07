import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/widgets/app_scaffold.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_cubit.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_state.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/widgets/entity_card.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class EntityListScreen extends StatelessWidget {
  const EntityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppLocalizations.of(context).appTitle,
      body: BlocBuilder<EntityListCubit, EntityListState>(
        builder: (context, state) => ListView.separated(
          key: const PageStorageKey('entity-list'),
          padding: const EdgeInsets.all(16),
          itemCount: state.items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entity = state.items[index];
            return EntityCard(
              entity: entity,
              typeLabel: state.typeLabelOf(entity),
            );
          },
        ),
      ),
    );
  }
}

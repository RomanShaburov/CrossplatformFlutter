import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wikidata_catalog/common/widgets/app_scaffold.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/entity_detail_screen.dart';
import 'package:wikidata_catalog/features/entity/presentation/view/entity_list_screen.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';

  static String detail(String id) => '/entity/$id';
}

abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const EntityListScreen(),
          routes: [
            GoRoute(
              path: 'entity/:id',
              builder: (context, state) =>
                  EntityDetailScreen(id: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      title: l10n.appTitle,
      body: Center(child: Text(l10n.pageNotFound)),
    );
  }
}

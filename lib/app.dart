import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/locale/locale_cubit.dart';
import 'package:wikidata_catalog/common/navigation/app_router.dart';
import 'package:wikidata_catalog/common/network/dio_client.dart';
import 'package:wikidata_catalog/common/theme/app_theme.dart';
import 'package:wikidata_catalog/common/theme/theme_cubit.dart';
import 'package:wikidata_catalog/features/entity/data/api/entity_api.dart';
import 'package:wikidata_catalog/features/entity/data/data_sources/network_entity_data_source.dart';
import 'package:wikidata_catalog/features/entity/data/entity_repository.dart';
import 'package:wikidata_catalog/features/entity/domain/i_entity_repository.dart';
import 'package:wikidata_catalog/features/entity/presentation/bloc/list/entity_list_cubit.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (_) => createDio(),
          dispose: (dio) => dio.close(),
        ),
        RepositoryProvider<IEntityRepository>(
          create: (context) => EntityRepository(
            NetworkEntityDataSource(EntityApi(context.read<Dio>())),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                EntityListCubit(context.read<IEntityRepository>())..load(),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => LocaleCubit()),
        ],
        child: Builder(
          builder: (context) => MaterialApp.router(
            routerConfig: AppRouter.router,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: context.watch<ThemeCubit>().state,
            locale: context.watch<LocaleCubit>().state,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}

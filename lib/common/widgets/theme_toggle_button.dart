import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/theme/theme_cubit.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return IconButton(
      onPressed: context.read<ThemeCubit>().toggle,
      tooltip: AppLocalizations.of(context).actionToggleTheme,
      icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikidata_catalog/common/locale/locale_cubit.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Tooltip(
      message: l10n.actionToggleLanguage,
      child: TextButton(
        onPressed: context.read<LocaleCubit>().toggle,
        child: Text(l10n.languageCode),
      ),
    );
  }
}

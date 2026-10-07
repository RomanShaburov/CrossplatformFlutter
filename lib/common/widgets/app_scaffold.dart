import 'package:flutter/material.dart';
import 'package:wikidata_catalog/common/widgets/language_toggle_button.dart';
import 'package:wikidata_catalog/common/widgets/theme_toggle_button.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [LanguageToggleButton(), ThemeToggleButton()],
      ),
      body: body,
    );
  }
}

# CrossplatformFlutter

Каталог сущностей Wikidata на Flutter. Список и карточки загружаются через Wikidata Action API. Стартовая подборка содержит 20 идентификаторов из ЛР2. Поиск по названию и псевдонимам охватывает всю Wikidata. Каталог загружает по восемь записей за раз.

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d edge
flutter run -d windows
```

## Проверки

```bash
flutter analyze
dart run tool/check_arb.dart
```

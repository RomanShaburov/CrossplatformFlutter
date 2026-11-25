import '../../domain/entity_model.dart';
import '../dto/entity_dto.dart';

// Properties presented by the catalogue, in the order used on the detail screen.
const _properties = [
  'P31',
  'P279',
  'P17',
  'P27',
  'P19',
  'P569',
  'P570',
  'P106',
  'P800',
  'P170',
  'P276',
  'P131',
  'P36',
  'P1082',
  'P571',
  'P361',
  'P397',
  'P61',
  'P856',
];

extension EntityDtoMapper on EntityDto {
  String get label => labels?['ru']?.value ?? labels?['en']?.value ?? id;

  EntityModel toModel({bool detail = false}) {
    final properties = <String, List<ClaimValue>>{};
    for (final key in detail ? _properties : const ['P31']) {
      final statements = claims?[key] ?? [];
      final preferred = statements.where((s) => s.rank == 'preferred');
      final current = preferred.isEmpty
          ? statements.where((s) => s.rank == 'normal')
          : preferred;
      final values = current
          .map((s) => _claim(s.mainsnak.datavalue))
          .nonNulls
          .toList();
      if (values.isNotEmpty) properties[key] = values;
    }
    return EntityModel(
      id: id,
      label: label,
      description:
          descriptions?['ru']?.value ?? descriptions?['en']?.value ?? '',
      aliases: [
        for (final term in aliases?['ru'] ?? aliases?['en'] ?? <TermDto>[])
          term.value,
      ],
      claims: properties,
      wikipediaTitle:
          sitelinks?['ruwiki']?.title ?? sitelinks?['enwiki']?.title,
    );
  }
}

ClaimValue? _claim(DataValueDto? data) => switch ((data?.type, data?.value)) {
  ('wikibase-entityid', {'id': final String id}) => EntityRef(id),
  ('time', {'time': final String time, 'precision': final int precision}) =>
    _date(time, precision),
  ('quantity', {'amount': final String amount}) => switch (int.tryParse(
    amount,
  )) {
    final int value => QuantityValue(value),
    null => TextValue(amount),
  },
  ('string', final String text) => TextValue(text),
  ('monolingualtext', {'text': final String text}) => TextValue(text),
  _ => null,
};

ClaimValue _date(String time, int precision) {
  final parts = RegExp(r'^([+-]?\d+)-(\d{2})-(\d{2})T').firstMatch(time);
  if (parts == null || precision < 9) return TextValue(time.split('T').first);
  final year = int.tryParse(parts[1]!);
  if (year == null || year < 1 || year > 9999) {
    return TextValue(time.split('T').first);
  }
  final unit = switch (precision) {
    9 => DatePrecision.year,
    10 => DatePrecision.month,
    _ => DatePrecision.day,
  };
  return DateValue(
    DateTime.utc(
      year,
      precision >= 10 ? int.parse(parts[2]!) : 1,
      precision >= 11 ? int.parse(parts[3]!) : 1,
    ),
    unit,
  );
}

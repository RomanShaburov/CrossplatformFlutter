import 'package:intl/intl.dart';
import 'package:wikidata_catalog/features/entity/domain/entity_model.dart';
import 'package:wikidata_catalog/l10n/app_localizations.dart';

extension DateValueFormat on DateValue {
  String display(String locale) => switch (precision) {
    DatePrecision.day => DateFormat.yMMMMd(locale).format(date),
    DatePrecision.month => DateFormat.yMMMM(locale).format(date),
    DatePrecision.year => DateFormat.y(locale).format(date),
  };
}

extension QuantityValueFormat on QuantityValue {
  String display(String locale) =>
      NumberFormat.decimalPattern(locale).format(amount);
}

extension PropertyLabels on AppLocalizations {
  String property(String id) => switch (id) {
    'P31' => propertyInstanceOf,
    'P279' => propertySubclassOf,
    'P17' => propertyCountry,
    'P27' => propertyCitizenship,
    'P19' => propertyPlaceOfBirth,
    'P569' => propertyDateOfBirth,
    'P570' => propertyDateOfDeath,
    'P106' => propertyOccupation,
    'P800' => propertyNotableWork,
    'P170' => propertyCreator,
    'P276' => propertyLocation,
    'P131' => propertyAdminUnit,
    'P36' => propertyCapital,
    'P1082' => propertyPopulation,
    'P571' => propertyInception,
    'P361' => propertyPartOf,
    'P397' => propertyParentBody,
    'P61' => propertyInventor,
    'P856' => propertyWebsite,
    _ => id,
  };
}

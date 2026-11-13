final class EntityModel {
  const EntityModel({
    required this.id,
    required this.label,
    required this.description,
    required this.aliases,
    required this.claims,
    this.wikipediaTitle,
  });

  final String id;
  final String label;
  final String description;
  final List<String> aliases;
  final Map<String, List<ClaimValue>> claims;
  final String? wikipediaTitle;
}

sealed class ClaimValue {
  const ClaimValue();
}

final class EntityRef extends ClaimValue {
  const EntityRef(this.id);

  final String id;
}

enum DatePrecision { year, month, day }

final class DateValue extends ClaimValue {
  const DateValue(this.date, this.precision);

  final DateTime date;
  final DatePrecision precision;
}

final class QuantityValue extends ClaimValue {
  const QuantityValue(this.amount);

  final int amount;
}

final class TextValue extends ClaimValue {
  const TextValue(this.text);

  final String text;
}

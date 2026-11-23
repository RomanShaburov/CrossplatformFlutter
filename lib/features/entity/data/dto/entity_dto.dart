import 'package:json_annotation/json_annotation.dart';

part 'entity_dto.g.dart';

@JsonSerializable(createToJson: false, checked: true)
class EntitiesDto {
  const EntitiesDto(this.entities);
  final Map<String, EntityDto> entities;
  factory EntitiesDto.fromJson(Map<String, dynamic> json) =>
      _$EntitiesDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class SearchDto {
  const SearchDto(this.search, this.next);
  final List<SearchHitDto> search;
  @JsonKey(name: 'search-continue')
  final int? next;
  factory SearchDto.fromJson(Map<String, dynamic> json) =>
      _$SearchDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class SearchHitDto {
  const SearchHitDto(this.id);
  final String id;
  factory SearchHitDto.fromJson(Map<String, dynamic> json) =>
      _$SearchHitDtoFromJson(json);
}

// Wikibase may encode an empty dictionary as [] in Action API responses.
Object? _dictionary(Map<dynamic, dynamic> json, String key) {
  final value = json[key];
  return value is List && value.isEmpty ? null : value;
}

@JsonSerializable(createToJson: false, checked: true)
class EntityDto {
  const EntityDto(
    this.id,
    this.missing,
    this.labels,
    this.descriptions,
    this.aliases,
    this.claims,
    this.sitelinks,
  );
  final String id;
  final Object? missing;
  @JsonKey(readValue: _dictionary)
  final Map<String, TermDto>? labels;
  @JsonKey(readValue: _dictionary)
  final Map<String, TermDto>? descriptions;
  @JsonKey(readValue: _dictionary)
  final Map<String, List<TermDto>>? aliases;
  @JsonKey(readValue: _dictionary)
  final Map<String, List<ClaimDto>>? claims;
  @JsonKey(readValue: _dictionary)
  final Map<String, SiteLinkDto>? sitelinks;
  factory EntityDto.fromJson(Map<String, dynamic> json) =>
      _$EntityDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class TermDto {
  const TermDto(this.value);
  final String value;
  factory TermDto.fromJson(Map<String, dynamic> json) =>
      _$TermDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class SiteLinkDto {
  const SiteLinkDto(this.title);
  final String title;
  factory SiteLinkDto.fromJson(Map<String, dynamic> json) =>
      _$SiteLinkDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class ClaimDto {
  const ClaimDto(this.mainsnak, this.rank);
  final SnakDto mainsnak;
  final String rank;
  factory ClaimDto.fromJson(Map<String, dynamic> json) =>
      _$ClaimDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class SnakDto {
  const SnakDto(this.datavalue);
  final DataValueDto? datavalue;
  factory SnakDto.fromJson(Map<String, dynamic> json) =>
      _$SnakDtoFromJson(json);
}

@JsonSerializable(createToJson: false, checked: true)
class DataValueDto {
  const DataValueDto(this.type, this.value);
  final String type;
  final Object? value;
  factory DataValueDto.fromJson(Map<String, dynamic> json) =>
      _$DataValueDtoFromJson(json);
}

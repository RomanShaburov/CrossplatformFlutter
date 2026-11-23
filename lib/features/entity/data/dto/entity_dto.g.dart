// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntitiesDto _$EntitiesDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EntitiesDto', json, ($checkedConvert) {
      final val = EntitiesDto(
        $checkedConvert(
          'entities',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) =>
                MapEntry(k, EntityDto.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      );
      return val;
    });

SearchDto _$SearchDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchDto', json, ($checkedConvert) {
      final val = SearchDto(
        $checkedConvert(
          'search',
          (v) => (v as List<dynamic>)
              .map((e) => SearchHitDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        $checkedConvert('search-continue', (v) => (v as num?)?.toInt()),
      );
      return val;
    }, fieldKeyMap: const {'next': 'search-continue'});

SearchHitDto _$SearchHitDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchHitDto', json, ($checkedConvert) {
      final val = SearchHitDto($checkedConvert('id', (v) => v as String));
      return val;
    });

EntityDto _$EntityDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EntityDto', json, ($checkedConvert) {
      final val = EntityDto(
        $checkedConvert('id', (v) => v as String),
        $checkedConvert('missing', (v) => v),
        $checkedConvert(
          'labels',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, TermDto.fromJson(e as Map<String, dynamic>)),
          ),
          readValue: _dictionary,
        ),
        $checkedConvert(
          'descriptions',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, TermDto.fromJson(e as Map<String, dynamic>)),
          ),
          readValue: _dictionary,
        ),
        $checkedConvert(
          'aliases',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => TermDto.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ),
          readValue: _dictionary,
        ),
        $checkedConvert(
          'claims',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => ClaimDto.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ),
          readValue: _dictionary,
        ),
        $checkedConvert(
          'sitelinks',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, SiteLinkDto.fromJson(e as Map<String, dynamic>)),
          ),
          readValue: _dictionary,
        ),
      );
      return val;
    });

TermDto _$TermDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TermDto', json, ($checkedConvert) {
      final val = TermDto($checkedConvert('value', (v) => v as String));
      return val;
    });

SiteLinkDto _$SiteLinkDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SiteLinkDto', json, ($checkedConvert) {
      final val = SiteLinkDto($checkedConvert('title', (v) => v as String));
      return val;
    });

ClaimDto _$ClaimDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ClaimDto', json, ($checkedConvert) {
      final val = ClaimDto(
        $checkedConvert(
          'mainsnak',
          (v) => SnakDto.fromJson(v as Map<String, dynamic>),
        ),
        $checkedConvert('rank', (v) => v as String),
      );
      return val;
    });

SnakDto _$SnakDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SnakDto',
  json,
  ($checkedConvert) {
    final val = SnakDto(
      $checkedConvert(
        'datavalue',
        (v) =>
            v == null ? null : DataValueDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

DataValueDto _$DataValueDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DataValueDto', json, ($checkedConvert) {
      final val = DataValueDto(
        $checkedConvert('type', (v) => v as String),
        $checkedConvert('value', (v) => v),
      );
      return val;
    });

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_respo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRespo _$SearchRespoFromJson(Map<String, dynamic> json) => SearchRespo(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => SearchResultData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SearchRespoToJson(SearchRespo instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

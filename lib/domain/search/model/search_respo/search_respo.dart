import 'package:json_annotation/json_annotation.dart';

import 'result.dart';

part 'search_respo.g.dart';

@JsonSerializable()
class SearchRespo {
  @JsonKey(name: 'results')
  List<SearchResultData> results;

  SearchRespo({
    this.results = const [],
  });

  factory SearchRespo.fromJson(Map<String, dynamic> json) {
    return _$SearchRespoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchRespoToJson(this);
}

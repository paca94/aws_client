import 'package:json_annotation/json_annotation.dart';

part 'region_config.g.dart';

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class RegionConfigData {
  final Map<String, Object> rules;
  final Map<String, RegionConfig> patterns;
  @JsonKey(name: "fipsRules", fromJson: mapFipsRulesFromJson)
  final Map<String, dynamic> fipsRules;
  @JsonKey(name: "dualstackRules", fromJson: mapDualstackRulesFromJson)
  final Map<String, dynamic> dualstackRules;
  @JsonKey(name: "dualstackFipsRules", fromJson: mapDualstackFipsRulesFromJson)
  final Map<String, dynamic> dualstackFipsRules;

  RegionConfigData(this.rules, this.patterns, this.fipsRules, this.dualstackRules, this.dualstackFipsRules);

  static RegionConfigData fromJson(Map<String, dynamic> json) =>
      _$RegionConfigDataFromJson(json);

  static mapFipsRulesFromJson(Map<String, dynamic> json) {
    return (json as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e is String ? e : RegionConfig.fromJson(e as Map<String, dynamic>)),
    );
  }

  static mapDualstackRulesFromJson(Map<String, dynamic> json) {
    return (json as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e is String ? e : RegionConfig.fromJson(e as Map<String, dynamic>)),
    );
  }

  static mapDualstackFipsRulesFromJson(Map<String, dynamic> json) {
    return (json as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e is String ? e : RegionConfig.fromJson(e as Map<String, dynamic>)),
    );
  }
}

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class RegionConfig {
  final String endpoint;
  final bool? globalEndpoint;
  final String? signatureVersion;
  final String? signingRegion;

  RegionConfig(this.endpoint, this.globalEndpoint, this.signatureVersion,
      this.signingRegion);

  static RegionConfig fromJson(Map<String, dynamic> json) =>
      _$RegionConfigFromJson(json);
}

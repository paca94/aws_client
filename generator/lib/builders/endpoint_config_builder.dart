import 'package:aws_client.generator/model/region_config.dart';

String buildEndpointConfig(RegionConfigData regionConfigData) {
  final allRules = [
    ['rules', regionConfigData.rules],
    ['fipsRules', regionConfigData.fipsRules],
    ['dualstackRules', regionConfigData.dualstackRules],
    ['dualstackFipsRules', regionConfigData.dualstackFipsRules]
  ];
  final code = StringBuffer()..writeln('''
// AUTO-GENERATED: This file is generated by the `generator` package

import 'endpoint.dart';
''');
  for (final currentRule in allRules) {
    final ruleName = currentRule[0];
    final rule = currentRule[1] as Map<String, Object>;
    code.writeln('final $ruleName = <String, RegionConfig>{');
    for (var ruleEntry in rule.entries) {
      final value = ruleEntry.value;
      String valueCode;
      if (value is String) {
        valueCode = '_$value';
        if (valueCode.contains('.')) {
          valueCode = dotKeyReplace(valueCode);
        }
      } else {
        final regionConfig =
            RegionConfig.fromJson(value as Map<String, dynamic>);
        valueCode = _regionConfigToCode(regionConfig);
      }

      code.writeln("'${ruleEntry.key}': $valueCode,");
    }

    code.writeln('};');
  }

  for (var pattern in regionConfigData.patterns.entries) {
    var patternKey = pattern.key;
    if (patternKey.contains('.')) {
      patternKey = dotKeyReplace(patternKey);
    }
    code.writeln('');
    code.writeln(
        'final _$patternKey = ${_regionConfigToCode(pattern.value)};');
  }

  return '$code';
}

String dotKeyReplace(String currentKey) {
  return currentKey.split('.').reduce((value, element) {
    return '$value${element[0].toUpperCase()}${element.substring(1)}';
  });
}

String _regionConfigToCode(RegionConfig config) {
  final properties = {
    'endpoint': config.endpoint,
    'globalEndpoint': config.globalEndpoint,
    'signatureVersion': config.signatureVersion,
    'signingRegion': config.signingRegion,
  };

  final code = StringBuffer('RegionConfig(');
  for (var property in properties.entries.where((e) => e.value != null)) {
    final propertyValue = property.value;
    String valueCode;
    if (propertyValue is bool) {
      valueCode = '$propertyValue';
    } else {
      valueCode = "'$propertyValue'";
    }
    code.writeln('${property.key}: $valueCode,');
  }
  code.writeln(')');
  return '$code';
}

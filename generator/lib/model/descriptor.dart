import 'package:json_annotation/json_annotation.dart';

import 'api.dart';
import 'dart_type.dart';
import 'error.dart';
import 'xml_namespace.dart';

part 'descriptor.g.dart';

@JsonSerializable(createToJson: false, disallowUnrecognizedKeys: true)
class Descriptor {
  @JsonKey(ignore: true)
  Api api;
  final String shape;
  final String resultWrapper;
  final String locationName;
  final String documentation;
  @JsonKey(defaultValue: false)
  final bool exception;
  final HttpError error;
  @JsonKey(defaultValue: false)
  final bool fault;
  final XmlNamespace xmlNamespace;
  @JsonKey(defaultValue: false)
  final bool jsonvalue;

  Descriptor(
    this.shape,
    this.resultWrapper,
    this.locationName,
    this.documentation,
    this.exception,
    this.error,
    this.fault,
    this.xmlNamespace,
    this.jsonvalue,
  );

  factory Descriptor.fromJson(Map<String, dynamic> json) =>
      _$DescriptorFromJson(json);

  String get dartType {
    final shapeRef = api.shapes[shape];
    final shapeRefType = shapeRef.type;

    if (shapeRefType.isBasicType()) {
      return shapeRefType.getDartType();
    } else if (shapeRefType.isMapOrList()) {
      return getListOrMapDartType(shapeRef);
    } else {
      return shape;
    }
  }
}
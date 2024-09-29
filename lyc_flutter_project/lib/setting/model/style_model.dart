import 'package:json_annotation/json_annotation.dart';

part 'style_model.g.dart';

@JsonSerializable()
class StyleModel {
  final SpecModel spec;
  final StyleListModel preferredStyle;
  final StyleListModel nonPreferredStyle;
  @JsonKey(name: 'preferredMaterial')
  final MaterialModel preferredMaterials;
  @JsonKey(name: 'nonPreferredMaterial')
  final MaterialModel nonPreferredMaterials;
  @JsonKey(name: 'preferredFit')
  final FitModel preferredFits;
  @JsonKey(name: 'nonPreferredFit')
  final FitModel nonPreferredFits;
  @JsonKey(name: 'goodBodyType')
  final BodyTypeModel goodBodyTypes;
  @JsonKey(name: 'badBodyType')
  final BodyTypeModel badBodyTypes;
  final String details;

  const StyleModel({
    required this.spec,
    required this.preferredStyle,
    required this.nonPreferredStyle,
    required this.preferredMaterials,
    required this.nonPreferredMaterials,
    required this.preferredFits,
    required this.nonPreferredFits,
    required this.goodBodyTypes,
    required this.badBodyTypes,
    required this.details,
  });

  factory StyleModel.fromJson(Map<String, dynamic> json)
  => _$StyleModelFromJson(json);

  Map<String, dynamic> toJson() => _$StyleModelToJson(this);
}

@JsonSerializable()
class SpecModel {
  final int height;
  final int weight;
  final String topSize;
  final String bottomSize;

  const SpecModel({
    required this.height,
    required this.weight,
    required this.topSize,
    required this.bottomSize,
  });

  factory SpecModel.fromJson(Map<String, dynamic> json) =>
      _$SpecModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecModelToJson(this);
}

@JsonSerializable()
class StyleListModel {
  final List<String> styles;

  const StyleListModel({
    required this.styles,
  });

  factory StyleListModel.fromJson(Map<String, dynamic> json) => _$StyleListModelFromJson(json);

  Map<String, dynamic> toJson() => _$StyleListModelToJson(this);
}

@JsonSerializable()
class MaterialModel {
  final List<String> materials;

  const MaterialModel({required this.materials});

  factory MaterialModel.fromJson(Map<String, dynamic> json) => _$MaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialModelToJson(this);
}

@JsonSerializable()
class FitModel {
  final List<String> fits;

  const FitModel({required this.fits});

  factory FitModel.fromJson(Map<String, dynamic> json) => _$FitModelFromJson(json);

  Map<String, dynamic> toJson() => _$FitModelToJson(this);
}

@JsonSerializable()
class BodyTypeModel {
  final List<String> bodyTypes;

  const BodyTypeModel({required this.bodyTypes});

  factory BodyTypeModel.fromJson(Map<String, dynamic> json) => _$BodyTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BodyTypeModelToJson(this);
}

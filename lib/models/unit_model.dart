/// Unit Category Enum
enum UnitCategory {
  weight,
  length,
  volume,
  temperature,
  area,
  speed,
}

/// Unit Model
class UnitModel {
  final String name;
  final String symbol;
  final double conversionFactor;
  final UnitCategory category;

  const UnitModel({
    required this.name,
    required this.symbol,
    required this.conversionFactor,
    required this.category,
  });

  @override
  String toString() => '$name ($symbol)';
}

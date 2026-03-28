/// Unit Category Enum with built-in methods
enum UnitCategory {
  weight,
  length,
  volume,
  temperature,
  area;

  String get displayName {
    switch (this) {
      case UnitCategory.weight:
        return 'Weight / Mass';
      case UnitCategory.length:
        return 'Length / Distance';
      case UnitCategory.volume:
        return 'Volume';
      case UnitCategory.temperature:
        return 'Temperature';
      case UnitCategory.area:
        return 'Area';
    }
  }

  String get icon {
    switch (this) {
      case UnitCategory.weight:
        return '⚖️';
      case UnitCategory.length:
        return '📏';
      case UnitCategory.volume:
        return '💧';
      case UnitCategory.temperature:
        return '🌡️';
      case UnitCategory.area:
        return '📐';
    }
  }

  List<UnitModel> get units {
    switch (this) {
      case UnitCategory.weight:
        return UnitModel.weightUnits;
      case UnitCategory.length:
        return UnitModel.lengthUnits;
      case UnitCategory.volume:
        return UnitModel.volumeUnits;
      case UnitCategory.temperature:
        return UnitModel.temperatureUnits;
      case UnitCategory.area:
        return UnitModel.areaUnits;
    }
  }
}

/// Unit Model Class
class UnitModel {
  final String name;
  final String symbol;
  final double conversionFactor; // Factor to convert to base unit
  final UnitCategory category;
  final bool isBaseUnit;

  const UnitModel({
    required this.name,
    required this.symbol,
    required this.conversionFactor,
    required this.category,
    this.isBaseUnit = false,
  });

  // Weight Units (Base: Gram)
  static const List<UnitModel> weightUnits = [
    UnitModel(name: 'Kilogram', symbol: 'kg', conversionFactor: 1000.0, category: UnitCategory.weight),
    UnitModel(name: 'Gram', symbol: 'g', conversionFactor: 1.0, category: UnitCategory.weight, isBaseUnit: true),
    UnitModel(name: 'Milligram', symbol: 'mg', conversionFactor: 0.001, category: UnitCategory.weight),
    UnitModel(name: 'Metric Ton', symbol: 't', conversionFactor: 1000000.0, category: UnitCategory.weight),
    UnitModel(name: 'Pound', symbol: 'lb', conversionFactor: 453.59237, category: UnitCategory.weight),
    UnitModel(name: 'Ounce', symbol: 'oz', conversionFactor: 28.349523125, category: UnitCategory.weight),
  ];

  // Length Units (Base: Meter)
  static const List<UnitModel> lengthUnits = [
    UnitModel(name: 'Meter', symbol: 'm', conversionFactor: 1.0, category: UnitCategory.length, isBaseUnit: true),
    UnitModel(name: 'Kilometer', symbol: 'km', conversionFactor: 1000.0, category: UnitCategory.length),
    UnitModel(name: 'Centimeter', symbol: 'cm', conversionFactor: 0.01, category: UnitCategory.length),
    UnitModel(name: 'Millimeter', symbol: 'mm', conversionFactor: 0.001, category: UnitCategory.length),
    UnitModel(name: 'Mile', symbol: 'mi', conversionFactor: 1609.344, category: UnitCategory.length),
    UnitModel(name: 'Yard', symbol: 'yd', conversionFactor: 0.9144, category: UnitCategory.length),
    UnitModel(name: 'Foot', symbol: 'ft', conversionFactor: 0.3048, category: UnitCategory.length),
    UnitModel(name: 'Inch', symbol: 'in', conversionFactor: 0.0254, category: UnitCategory.length),
  ];

  // Volume Units (Base: Liter)
  static const List<UnitModel> volumeUnits = [
    UnitModel(name: 'Liter', symbol: 'L', conversionFactor: 1.0, category: UnitCategory.volume, isBaseUnit: true),
    UnitModel(name: 'Milliliter', symbol: 'mL', conversionFactor: 0.001, category: UnitCategory.volume),
    UnitModel(name: 'Cubic Meter', symbol: 'm³', conversionFactor: 1000.0, category: UnitCategory.volume),
    UnitModel(name: 'Gallon (US)', symbol: 'gal', conversionFactor: 3.785411784, category: UnitCategory.volume),
    UnitModel(name: 'Quart', symbol: 'qt', conversionFactor: 0.946352946, category: UnitCategory.volume),
    UnitModel(name: 'Pint', symbol: 'pt', conversionFactor: 0.473176473, category: UnitCategory.volume),
    UnitModel(name: 'Cup', symbol: 'cup', conversionFactor: 0.2365882365, category: UnitCategory.volume),
  ];

  // Temperature Units (Special handling required)
  static const List<UnitModel> temperatureUnits = [
    UnitModel(name: 'Celsius', symbol: '°C', conversionFactor: 1.0, category: UnitCategory.temperature, isBaseUnit: true),
    UnitModel(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1.0, category: UnitCategory.temperature),
    UnitModel(name: 'Kelvin', symbol: 'K', conversionFactor: 1.0, category: UnitCategory.temperature),
  ];

  // Area Units (Base: Square Meter)
  static const List<UnitModel> areaUnits = [
    UnitModel(name: 'Square Meter', symbol: 'm²', conversionFactor: 1.0, category: UnitCategory.area, isBaseUnit: true),
    UnitModel(name: 'Square Kilometer', symbol: 'km²', conversionFactor: 1000000.0, category: UnitCategory.area),
    UnitModel(name: 'Acre', symbol: 'ac', conversionFactor: 4046.8564224, category: UnitCategory.area),
    UnitModel(name: 'Hectare', symbol: 'ha', conversionFactor: 10000.0, category: UnitCategory.area),
  ];

  @override
  String toString() => '$name ($symbol)';
}

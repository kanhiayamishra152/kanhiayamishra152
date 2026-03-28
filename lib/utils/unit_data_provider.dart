import 'package:flutter/material.dart';
import '../models/unit_model.dart';

/// Unit Data Provider - Contains all unit definitions
class UnitDataProvider {
  /// Weight & Mass Units (base: kg)
  static const List<UnitModel> weightUnits = [
    UnitModel(name: 'Kilogram', symbol: 'kg', conversionFactor: 1.0, category: UnitCategory.weight),
    UnitModel(name: 'Gram', symbol: 'g', conversionFactor: 0.001, category: UnitCategory.weight),
    UnitModel(name: 'Milligram', symbol: 'mg', conversionFactor: 0.000001, category: UnitCategory.weight),
    UnitModel(name: 'Metric Ton', symbol: 't', conversionFactor: 1000.0, category: UnitCategory.weight),
    UnitModel(name: 'Pound', symbol: 'lb', conversionFactor: 0.45359237, category: UnitCategory.weight),
    UnitModel(name: 'Ounce', symbol: 'oz', conversionFactor: 0.02834952, category: UnitCategory.weight),
  ];

  /// Length & Distance Units (base: meter)
  static const List<UnitModel> lengthUnits = [
    UnitModel(name: 'Meter', symbol: 'm', conversionFactor: 1.0, category: UnitCategory.length),
    UnitModel(name: 'Kilometer', symbol: 'km', conversionFactor: 1000.0, category: UnitCategory.length),
    UnitModel(name: 'Centimeter', symbol: 'cm', conversionFactor: 0.01, category: UnitCategory.length),
    UnitModel(name: 'Millimeter', symbol: 'mm', conversionFactor: 0.001, category: UnitCategory.length),
    UnitModel(name: 'Mile', symbol: 'mi', conversionFactor: 1609.344, category: UnitCategory.length),
    UnitModel(name: 'Yard', symbol: 'yd', conversionFactor: 0.9144, category: UnitCategory.length),
    UnitModel(name: 'Foot', symbol: 'ft', conversionFactor: 0.3048, category: UnitCategory.length),
    UnitModel(name: 'Inch', symbol: 'in', conversionFactor: 0.0254, category: UnitCategory.length),
  ];

  /// Volume & Capacity Units (base: liter)
  static const List<UnitModel> volumeUnits = [
    UnitModel(name: 'Liter', symbol: 'L', conversionFactor: 1.0, category: UnitCategory.volume),
    UnitModel(name: 'Milliliter', symbol: 'mL', conversionFactor: 0.001, category: UnitCategory.volume),
    UnitModel(name: 'Cubic Meter', symbol: 'm³', conversionFactor: 1000.0, category: UnitCategory.volume),
    UnitModel(name: 'Gallon (US)', symbol: 'gal (US)', conversionFactor: 3.785411784, category: UnitCategory.volume),
    UnitModel(name: 'Gallon (UK)', symbol: 'gal (UK)', conversionFactor: 4.54609, category: UnitCategory.volume),
    UnitModel(name: 'Quart (US)', symbol: 'qt (US)', conversionFactor: 0.946352946, category: UnitCategory.volume),
    UnitModel(name: 'Pint (US)', symbol: 'pt (US)', conversionFactor: 0.473176473, category: UnitCategory.volume),
    UnitModel(name: 'Cup (US)', symbol: 'cup (US)', conversionFactor: 0.236588236, category: UnitCategory.volume),
  ];

  /// Temperature Units (special handling)
  static const List<UnitModel> temperatureUnits = [
    UnitModel(name: 'Celsius', symbol: '°C', conversionFactor: 1.0, category: UnitCategory.temperature),
    UnitModel(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1.0, category: UnitCategory.temperature),
    UnitModel(name: 'Kelvin', symbol: 'K', conversionFactor: 1.0, category: UnitCategory.temperature),
  ];

  /// Area Units (base: square meter)
  static const List<UnitModel> areaUnits = [
    UnitModel(name: 'Square Meter', symbol: 'm²', conversionFactor: 1.0, category: UnitCategory.area),
    UnitModel(name: 'Square Kilometer', symbol: 'km²', conversionFactor: 1000000.0, category: UnitCategory.area),
    UnitModel(name: 'Square Centimeter', symbol: 'cm²', conversionFactor: 0.0001, category: UnitCategory.area),
    UnitModel(name: 'Square Millimeter', symbol: 'mm²', conversionFactor: 0.000001, category: UnitCategory.area),
    UnitModel(name: 'Hectare', symbol: 'ha', conversionFactor: 10000.0, category: UnitCategory.area),
    UnitModel(name: 'Acre', symbol: 'ac', conversionFactor: 4046.856422, category: UnitCategory.area),
    UnitModel(name: 'Square Mile', symbol: 'mi²', conversionFactor: 2589988.11, category: UnitCategory.area),
    UnitModel(name: 'Square Yard', symbol: 'yd²', conversionFactor: 0.83612736, category: UnitCategory.area),
    UnitModel(name: 'Square Foot', symbol: 'ft²', conversionFactor: 0.09290304, category: UnitCategory.area),
    UnitModel(name: 'Square Inch', symbol: 'in²', conversionFactor: 0.00064516, category: UnitCategory.area),
  ];

  /// Speed Units (base: meter per second)
  static const List<UnitModel> speedUnits = [
    UnitModel(name: 'Meter/Second', symbol: 'm/s', conversionFactor: 1.0, category: UnitCategory.speed),
    UnitModel(name: 'Kilometer/Hour', symbol: 'km/h', conversionFactor: 0.277777778, category: UnitCategory.speed),
    UnitModel(name: 'Mile/Hour', symbol: 'mph', conversionFactor: 0.44704, category: UnitCategory.speed),
    UnitModel(name: 'Knot', symbol: 'kn', conversionFactor: 0.514444444, category: UnitCategory.speed),
    UnitModel(name: 'Foot/Second', symbol: 'ft/s', conversionFactor: 0.3048, category: UnitCategory.speed),
  ];

  /// Get units by category
  static List<UnitModel> getUnitsByCategory(UnitCategory category) {
    switch (category) {
      case UnitCategory.weight:
        return weightUnits;
      case UnitCategory.length:
        return lengthUnits;
      case UnitCategory.volume:
        return volumeUnits;
      case UnitCategory.temperature:
        return temperatureUnits;
      case UnitCategory.area:
        return areaUnits;
      case UnitCategory.speed:
        return speedUnits;
      default:
        return [];
    }
  }

  /// Get category name
  static String getCategoryName(UnitCategory category) {
    switch (category) {
      case UnitCategory.weight:
        return 'Weight & Mass';
      case UnitCategory.length:
        return 'Length & Distance';
      case UnitCategory.volume:
        return 'Volume & Capacity';
      case UnitCategory.temperature:
        return 'Temperature';
      case UnitCategory.area:
        return 'Area';
      case UnitCategory.speed:
        return 'Speed';
    }
  }

  /// Get category icon data
  static IconData getCategoryIcon(UnitCategory category) {
    switch (category) {
      case UnitCategory.weight:
        return Icons.scale;
      case UnitCategory.length:
        return Icons.straighten;
      case UnitCategory.volume:
        return Icons.water_drop;
      case UnitCategory.temperature:
        return Icons.thermostat;
      case UnitCategory.area:
        return Icons.square_foot;
      case UnitCategory.speed:
        return Icons.speed;
    }
  }

  /// Get category color
  static Color getCategoryColor(UnitCategory category, bool isDarkMode) {
    switch (category) {
      case UnitCategory.weight:
        return isDarkMode ? const Color(0xFF64B5F6) : const Color(0xFF1976D2);
      case UnitCategory.length:
        return isDarkMode ? const Color(0xFF81C784) : const Color(0xFF388E3C);
      case UnitCategory.volume:
        return isDarkMode ? const Color(0xFF4DB6AC) : const Color(0xFF00897B);
      case UnitCategory.temperature:
        return isDarkMode ? const Color(0xFFFF8A65) : const Color(0xFFF4511E);
      case UnitCategory.area:
        return isDarkMode ? const Color(0xFFBA68C8) : const Color(0xFF7B1FA2);
      case UnitCategory.speed:
        return isDarkMode ? const Color(0xFFFFD54F) : const Color(0xFFFF8F00);
    }
  }
}

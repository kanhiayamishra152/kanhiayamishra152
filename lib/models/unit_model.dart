// lib/models/unit_model.dart
import 'package:flutter/material.dart';

enum UnitCategory {
  weight,
  length,
  volume,
  temperature,
  area;

  String get displayName {
    switch (this) {
      case UnitCategory.weight:
        return 'Weight';
      case UnitCategory.length:
        return 'Length';
      case UnitCategory.volume:
        return 'Volume';
      case UnitCategory.temperature:
        return 'Temperature';
      case UnitCategory.area:
        return 'Area';
    }
  }

  IconData get icon {
    switch (this) {
      case UnitCategory.weight:
        return Icons.scale;
      case UnitCategory.length:
        return Icons.straighten;
      case UnitCategory.volume:
        return Icons.local_drink;
      case UnitCategory.temperature:
        return Icons.thermostat;
      case UnitCategory.area:
        return Icons.square_foot;
    }
  }

  List<UnitModel> get units {
    switch (this) {
      case UnitCategory.weight:
        return [
          UnitModel(name: 'Kilograms', symbol: 'kg', factor: 1),
          UnitModel(name: 'Grams', symbol: 'g', factor: 1000),
          UnitModel(name: 'Milligrams', symbol: 'mg', factor: 1000000),
          UnitModel(name: 'Metric Tons', symbol: 't', factor: 0.001),
          UnitModel(name: 'Pounds', symbol: 'lb', factor: 2.2046226218),
          UnitModel(name: 'Ounces', symbol: 'oz', factor: 35.27396195),
        ];
      case UnitCategory.length:
        return [
          UnitModel(name: 'Meters', symbol: 'm', factor: 1),
          UnitModel(name: 'Kilometers', symbol: 'km', factor: 0.001),
          UnitModel(name: 'Centimeters', symbol: 'cm', factor: 100),
          UnitModel(name: 'Millimeters', symbol: 'mm', factor: 1000),
          UnitModel(name: 'Miles', symbol: 'mi', factor: 0.0006213712),
          UnitModel(name: 'Yards', symbol: 'yd', factor: 1.0936132983),
          UnitModel(name: 'Feet', symbol: 'ft', factor: 3.280839895),
          UnitModel(name: 'Inches', symbol: 'in', factor: 39.37007874),
        ];
      case UnitCategory.volume:
        return [
          UnitModel(name: 'Liters', symbol: 'L', factor: 1),
          UnitModel(name: 'Milliliters', symbol: 'mL', factor: 1000),
          UnitModel(name: 'Cubic Meters', symbol: 'm³', factor: 0.001),
          UnitModel(name: 'Gallons (US)', symbol: 'gal', factor: 0.2641720524),
          UnitModel(name: 'Quarts', symbol: 'qt', factor: 1.0566882094),
          UnitModel(name: 'Pints', symbol: 'pt', factor: 2.1133764189),
          UnitModel(name: 'Cups', symbol: 'cup', factor: 4.1666666667),
        ];
      case UnitCategory.temperature:
        return [
          UnitModel(name: 'Celsius', symbol: '°C', factor: 1),
          UnitModel(name: 'Fahrenheit', symbol: '°F', factor: 1),
          UnitModel(name: 'Kelvin', symbol: 'K', factor: 1),
        ];
      case UnitCategory.area:
        return [
          UnitModel(name: 'Square Meters', symbol: 'm²', factor: 1),
          UnitModel(name: 'Square Kilometers', symbol: 'km²', factor: 0.000001),
          UnitModel(name: 'Acres', symbol: 'ac', factor: 0.0002471054),
          UnitModel(name: 'Hectares', symbol: 'ha', factor: 0.0001),
        ];
    }
  }
}

class UnitModel {
  final String name;
  final String symbol;
  final double factor;

  const UnitModel({
    required this.name,
    required this.symbol,
    required this.factor,
  });

  @override
  String toString() => '$name ($symbol)';
}

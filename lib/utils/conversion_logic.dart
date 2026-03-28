// lib/utils/conversion_logic.dart
import '../models/unit_model.dart';

class ConversionLogic {
  static double convert(
    double value,
    UnitCategory category,
    UnitModel fromUnit,
    UnitModel toUnit,
  ) {
    if (category == UnitCategory.temperature) {
      return _convertTemperature(value, fromUnit, toUnit);
    }

    double baseValue = value / fromUnit.factor;
    return baseValue * toUnit.factor;
  }

  static double _convertTemperature(double value, UnitModel fromUnit, UnitModel toUnit) {
    double celsiusValue;
    if (fromUnit.name == 'Celsius') {
      celsiusValue = value;
    } else if (fromUnit.name == 'Fahrenheit') {
      celsiusValue = (value - 32) * 5 / 9;
    } else if (fromUnit.name == 'Kelvin') {
      celsiusValue = value - 273.15;
    } else {
      celsiusValue = value;
    }

    if (toUnit.name == 'Celsius') {
      return double.parse(celsiusValue.toStringAsFixed(10));
    } else if (toUnit.name == 'Fahrenheit') {
      return double.parse(((celsiusValue * 9 / 5) + 32).toStringAsFixed(10));
    } else if (toUnit.name == 'Kelvin') {
      return double.parse((celsiusValue + 273.15).toStringAsFixed(10));
    }

    return celsiusValue;
  }

  static String formatResult(double result) {
    String formatted = result.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'0*$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    return formatted.isEmpty ? '0' : formatted;
  }
}

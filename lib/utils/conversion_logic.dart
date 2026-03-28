import 'unit_model.dart';

/// Unit Conversion Logic with High Precision
class ConversionLogic {
  /// Convert value from one unit to another within the same category
  static double convert({
    required double value,
    required UnitModel fromUnit,
    required UnitModel toUnit,
  }) {
    if (fromUnit.category != toUnit.category) {
      throw ArgumentError('Cannot convert between different categories');
    }

    // Temperature requires special handling
    if (fromUnit.category == UnitCategory.temperature) {
      return _convertTemperature(value, fromUnit.symbol, toUnit.symbol);
    }

    // For other units: convert to base unit first, then to target unit
    final baseValue = value * fromUnit.conversionFactor;
    final result = baseValue / toUnit.conversionFactor;
    
    return result;
  }

  /// Special temperature conversion logic
  static double _convertTemperature(double value, String fromSymbol, String toSymbol) {
    double celsius;

    // Convert to Celsius first
    switch (fromSymbol) {
      case '°C':
        celsius = value;
        break;
      case '°F':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'K':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Convert from Celsius to target
    switch (toSymbol) {
      case '°C':
        return celsius;
      case '°F':
        return (celsius * 9 / 5) + 32;
      case 'K':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  /// Format result with high precision (up to 10 decimal places)
  static String formatResult(double value) {
    if (value == 0) return '0';
    
    // Remove trailing zeros but keep up to 10 decimal places
    String formatted = value.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'0+$'), '');
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    
    return formatted;
  }
}

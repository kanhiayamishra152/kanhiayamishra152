/// Conversion Logic Utility with high precision (10 decimal places)
class ConversionLogic {
  /// Convert value from one unit to another within the same category
  static double convert({
    required double value,
    required UnitModel fromUnit,
    required UnitModel toUnit,
  }) {
    // Handle temperature separately due to non-linear conversion
    if (fromUnit.category == UnitCategory.temperature) {
      return _convertTemperature(value, fromUnit, toUnit);
    }

    // Standard conversion: value -> base unit -> target unit
    final double valueInBaseUnit = value * fromUnit.conversionFactor;
    final double result = valueInBaseUnit / toUnit.conversionFactor;
    
    return _roundToPrecision(result);
  }

  /// Temperature conversion with special formulas
  static double _convertTemperature(
    double value,
    UnitModel fromUnit,
    UnitModel toUnit,
  ) {
    if (fromUnit.name == toUnit.name) {
      return _roundToPrecision(value);
    }

    // First convert to Celsius as intermediate
    double celsius;
    
    // From source to Celsius
    switch (fromUnit.name) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Then convert from Celsius to target
    double result;
    switch (toUnit.name) {
      case 'Celsius':
        result = celsius;
        break;
      case 'Fahrenheit':
        result = (celsius * 9 / 5) + 32;
        break;
      case 'Kelvin':
        result = celsius + 273.15;
        break;
      default:
        result = celsius;
    }

    return _roundToPrecision(result);
  }

  /// Round to 10 decimal places for high precision
  static double _roundToPrecision(double value) {
    final double factor = 10000000000; // 10^10
    return (value * factor).round() / factor;
  }

  /// Format the result for display
  static String formatResult(double value) {
    // Remove trailing zeros and unnecessary decimal points
    String formatted = value.toStringAsFixed(10);
    
    // Remove trailing zeros
    formatted = formatted.replaceAll(RegExp(r'0+$'), '');
    
    // Remove trailing decimal point if no decimals left
    formatted = formatted.replaceAll(RegExp(r'\.$'), '');
    
    // Handle scientific notation for very large/small numbers
    if (formatted.length > 15) {
      formatted = value.toExponential(6);
    }
    
    return formatted;
  }
}

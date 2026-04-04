import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/unit_models.dart';
import '../models/unit_data.dart';

class ConverterProvider with ChangeNotifier {
  UnitCategory _selectedCategory = UnitCategory.weight;
  int _fromUnitIndex = 0;
  int _toUnitIndex = 1;
  String _inputValue = '';
  bool _isDarkMode = false;

  // Getters
  UnitCategory get selectedCategory => _selectedCategory;
  int get fromUnitIndex => _fromUnitIndex;
  int get toUnitIndex => _toUnitIndex;
  String get inputValue => _inputValue;
  bool get isDarkMode => _isDarkMode;
  
  CategoryData get currentCategory => UnitConstants.categories[_selectedCategory]!;
  List<UnitData> get currentUnits => currentCategory.units;
  
  UnitData get fromUnit => currentUnits[_fromUnitIndex];
  UnitData get toUnit => currentUnits[_toUnitIndex];

  // Setters with notification
  void setCategory(UnitCategory category) {
    _selectedCategory = category;
    _fromUnitIndex = 0;
    _toUnitIndex = 1;
    _inputValue = '';
    notifyListeners();
  }

  void setFromUnit(int index) {
    _fromUnitIndex = index;
    notifyListeners();
  }

  void setToUnit(int index) {
    _toUnitIndex = index;
    notifyListeners();
  }

  void setInputValue(String value) {
    _inputValue = value;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void swapUnits() {
    final temp = _fromUnitIndex;
    _fromUnitIndex = _toUnitIndex;
    _toUnitIndex = temp;
    notifyListeners();
  }

  // Conversion logic
  double convert() {
    if (_inputValue.isEmpty) return 0.0;
    
    double input = double.tryParse(_inputValue) ?? 0.0;
    
    // Special handling for temperature
    if (_selectedCategory == UnitCategory.temperature) {
      return _convertTemperature(input);
    }
    
    // Standard conversion: input -> base unit -> output unit
    double baseValue = input * fromUnit.conversionFactor;
    double result = baseValue / toUnit.conversionFactor;
    
    return result;
  }

  double _convertTemperature(double input) {
    // Convert from source to Celsius first
    double celsius;
    switch (_fromUnitIndex) {
      case 0: // Celsius
        celsius = input;
        break;
      case 1: // Fahrenheit
        celsius = (input - 32) * 5 / 9;
        break;
      case 2: // Kelvin
        celsius = input - 273.15;
        break;
      default:
        celsius = input;
    }
    
    // Convert from Celsius to target
    switch (_toUnitIndex) {
      case 0: // Celsius
        return celsius;
      case 1: // Fahrenheit
        return (celsius * 9 / 5) + 32;
      case 2: // Kelvin
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  String getFormattedResult() {
    double result = convert();
    
    // Format with high precision (up to 10 decimal places)
    if (result == 0.0) return '0';
    
    // Remove trailing zeros but keep up to 10 decimal places
    String formatted = result.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');
    
    // Handle very small or very large numbers
    if (formatted.length > 15 || (result.abs() < 0.000001 && result != 0)) {
      return result.toPrecision(10);
    }
    
    return formatted;
  }

  Future<void> copyToClipboard() async {
    String result = getFormattedResult();
    await Clipboard.setData(ClipboardData(text: '$result ${toUnit.symbol}'));
  }
}

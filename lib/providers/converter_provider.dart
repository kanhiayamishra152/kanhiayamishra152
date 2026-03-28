import 'package:flutter/material.dart';
import '../models/unit_model.dart';
import '../utils/conversion_logic.dart';
import '../utils/unit_data_provider.dart';

/// Converter Provider - Manages conversion state and logic
class ConverterProvider with ChangeNotifier {
  UnitCategory _selectedCategory = UnitCategory.weight;
  UnitModel _fromUnit = UnitDataProvider.weightUnits[0];
  UnitModel _toUnit = UnitDataProvider.weightUnits[1];
  String _inputValue = '';
  double _result = 0.0;
  bool _isDarkMode = false;

  // Getters
  UnitCategory get selectedCategory => _selectedCategory;
  UnitModel get fromUnit => _fromUnit;
  UnitModel get toUnit => _toUnit;
  String get inputValue => _inputValue;
  double get result => _result;
  bool get isDarkMode => _isDarkMode;
  
  List<UnitModel> get availableUnits => 
      UnitDataProvider.getUnitsByCategory(_selectedCategory);

  /// Change selected category
  void setCategory(UnitCategory category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      final units = UnitDataProvider.getUnitsByCategory(category);
      _fromUnit = units[0];
      _toUnit = units.length > 1 ? units[1] : units[0];
      _inputValue = '';
      _result = 0.0;
      notifyListeners();
    }
  }

  /// Update input value and calculate result
  void setInputValue(String value) {
    _inputValue = value;
    _calculateResult();
    notifyListeners();
  }

  /// Set from unit
  void setFromUnit(UnitModel unit) {
    _fromUnit = unit;
    _calculateResult();
    notifyListeners();
  }

  /// Set to unit
  void setToUnit(UnitModel unit) {
    _toUnit = unit;
    _calculateResult();
    notifyListeners();
  }

  /// Swap from and to units
  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;
    _calculateResult();
    notifyListeners();
  }

  /// Toggle dark mode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// Set dark mode explicitly
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  /// Calculate conversion result
  void _calculateResult() {
    if (_inputValue.isEmpty) {
      _result = 0.0;
      return;
    }

    try {
      final value = double.parse(_inputValue);
      _result = ConversionLogic.convert(
        value: value,
        fromUnit: _fromUnit,
        toUnit: _toUnit,
      );
    } catch (e) {
      _result = 0.0;
    }
  }

  /// Get formatted result string
  String getFormattedResult() {
    if (_inputValue.isEmpty) return '---';
    return ConversionLogic.formatResult(_result);
  }

  /// Get current color based on category and theme
  Color getCurrentColor() {
    return UnitDataProvider.getCategoryColor(_selectedCategory, _isDarkMode);
  }
}

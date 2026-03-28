// lib/providers/converter_provider.dart
import 'package:flutter/material.dart';
import '../models/unit_model.dart';
import '../utils/conversion_logic.dart';

class ConverterProvider extends ChangeNotifier {
  UnitCategory _selectedCategory = UnitCategory.weight;
  UnitModel _fromUnit = UnitCategory.weight.units[0];
  UnitModel _toUnit = UnitCategory.weight.units[1];
  String _inputValue = '';
  String _result = '';

  UnitCategory get selectedCategory => _selectedCategory;
  UnitModel get fromUnit => _fromUnit;
  UnitModel get toUnit => _toUnit;
  String get inputValue => _inputValue;
  String get result => _result;

  void selectCategory(UnitCategory category) {
    _selectedCategory = category;
    _fromUnit = category.units[0];
    _toUnit = category.units[1];
    _calculateResult();
    notifyListeners();
  }

  void selectFromUnit(UnitModel unit) {
    _fromUnit = unit;
    _calculateResult();
    notifyListeners();
  }

  void selectToUnit(UnitModel unit) {
    _toUnit = unit;
    _calculateResult();
    notifyListeners();
  }

  void setInputValue(String value) {
    _inputValue = value;
    _calculateResult();
    notifyListeners();
  }

  void swapUnits() {
    UnitModel temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;
    _calculateResult();
    notifyListeners();
  }

  void _calculateResult() {
    if (_inputValue.isEmpty) {
      _result = '';
      return;
    }

    double? value = double.tryParse(_inputValue);
    if (value == null) {
      _result = '';
      return;
    }

    try {
      double convertedValue = ConversionLogic.convert(
        value,
        _selectedCategory,
        _fromUnit,
        _toUnit,
      );
      _result = ConversionLogic.formatResult(convertedValue);
    } catch (e) {
      _result = 'Error';
    }
  }
}

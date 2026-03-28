import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/unit_model.dart';
import '../utils/conversion_logic.dart';
import '../providers/theme_provider.dart';

class ConverterProvider with ChangeNotifier {
  UnitCategory _selectedCategory = UnitCategory.weight;
  UnitModel? _fromUnit;
  UnitModel? _toUnit;
  String _inputValue = '';
  double _result = 0.0;

  // Getters
  UnitCategory get selectedCategory => _selectedCategory;
  UnitModel? get fromUnit => _fromUnit;
  UnitModel? get toUnit => _toUnit;
  String get inputValue => _inputValue;
  double get result => _result;
  
  List<UnitModel> get availableUnits => _selectedCategory.units;
  
  String get formattedResult => ConversionLogic.formatResult(_result);

  // Set category and initialize units
  void setCategory(UnitCategory category) {
    _selectedCategory = category;
    final units = category.units;
    _fromUnit = units.isNotEmpty ? units[0] : null;
    _toUnit = units.length > 1 ? units[1] : units.isNotEmpty ? units[0] : null;
    _performConversion();
  }

  // Set from unit
  void setFromUnit(UnitModel? unit) {
    _fromUnit = unit;
    _performConversion();
  }

  // Set to unit
  void setToUnit(UnitModel? unit) {
    _toUnit = unit;
    _performConversion();
  }

  // Set input value
  void setInputValue(String value) {
    _inputValue = value;
    _performConversion();
  }

  // Swap units
  void swapUnits() {
    final temp = _fromUnit;
    _fromUnit = _toUnit;
    _toUnit = temp;
    _performConversion();
  }

  // Perform conversion
  void _performConversion() {
    if (_fromUnit != null && _toUnit != null && _inputValue.isNotEmpty) {
      final double? value = double.tryParse(_inputValue);
      if (value != null) {
        _result = ConversionLogic.convert(
          value: value,
          fromUnit: _fromUnit!,
          toUnit: _toUnit!,
        );
      } else {
        _result = 0.0;
      }
    } else {
      _result = 0.0;
    }
    notifyListeners();
  }

  // Copy result to clipboard (returns the formatted result string)
  String getCopyableResult() {
    return formattedResult;
  }

  // Get result with unit symbol
  String getResultWithSymbol() {
    if (_toUnit != null) {
      return '${formattedResult} ${_toUnit!.symbol}';
    }
    return formattedResult;
  }
}

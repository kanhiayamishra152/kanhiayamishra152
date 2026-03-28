// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/unit_model.dart';
import '../providers/converter_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final converterProvider = context.watch<ConverterProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: UnitCategory.values.map((category) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(category.icon, size: 16),
                      SizedBox(width: 4),
                      Text(category.displayName),
                    ],
                  ),
                  selected: converterProvider.selectedCategory == category,
                  onSelected: (selected) {
                    if (selected) {
                      converterProvider.selectCategory(category);
                    }
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                    color: converterProvider.selectedCategory == category 
                        ? Colors.white 
                        : Colors.black,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _inputController,
                            onChanged: (value) => converterProvider.setInputValue(value),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Enter Value',
                              prefixIcon: Icon(Icons.numbers),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<UnitModel>(
                            value: converterProvider.fromUnit,
                            items: converterProvider.selectedCategory.units
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit.name),
                                    ))
                                .toList(),
                            onChanged: (UnitModel? newValue) {
                              if (newValue != null) {
                                converterProvider.selectFromUnit(newValue);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'From',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: converterProvider.swapUnits,
                          icon: Icon(Icons.swap_horiz),
                          label: Text('Swap'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              converterProvider.result.isNotEmpty 
                                  ? converterProvider.result 
                                  : '--',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<UnitModel>(
                            value: converterProvider.toUnit,
                            items: converterProvider.selectedCategory.units
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit.name),
                                    ))
                                .toList(),
                            onChanged: (UnitModel? newValue) {
                              if (newValue != null) {
                                converterProvider.selectToUnit(newValue);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'To',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (converterProvider.result.isNotEmpty) {
                          Clipboard.setData(ClipboardData(text: converterProvider.result));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Copied to clipboard')),
                          );
                        }
                      },
                      icon: Icon(Icons.copy),
                      label: Text('Copy Result'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

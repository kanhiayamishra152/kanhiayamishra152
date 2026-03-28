import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/unit_model.dart';
import '../providers/converter_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with weight category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ConverterProvider>().setCategory(UnitCategory.weight);
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onCategorySelected(UnitCategory category) {
    context.read<ConverterProvider>().setCategory(category);
    _inputController.clear();
    context.read<ConverterProvider>().setInputValue('');
  }

  void _copyToClipboard() {
    final provider = context.read<ConverterProvider>();
    final resultWithSymbol = provider.getResultWithSymbol();
    
    Clipboard.setData(ClipboardData(text: resultWithSymbol));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: $resultWithSymbol'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final converterProvider = context.watch<ConverterProvider>();
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Selection
            _buildCategorySelector(converterProvider),
            
            const SizedBox(height: 24),
            
            // Conversion Card
            _buildConversionCard(converterProvider, isDarkMode),
            
            const SizedBox(height: 24),
            
            // Result Display
            _buildResultDisplay(converterProvider, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(ConverterProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: UnitCategory.values.map((category) {
            final isSelected = provider.selectedCategory == category;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(category.icon, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(category.displayName),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) _onCategorySelected(category);
              },
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConversionCard(ConverterProvider provider, bool isDarkMode) {
    return Card(
      elevation: 8,
      shadowColor: isDarkMode ? Colors.black45 : Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // From Unit Section
            _buildUnitSelector(
              label: 'From',
              selectedUnit: provider.fromUnit,
              units: provider.availableUnits,
              onChanged: (unit) => provider.setFromUnit(unit),
              isDarkMode: isDarkMode,
            ),
            
            const SizedBox(height: 16),
            
            // Input Field
            TextField(
              controller: _inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                labelText: 'Value',
                hintText: 'Enter value',
                prefixIcon: const Icon(Icons.edit),
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              onChanged: (value) => provider.setInputValue(value),
            ),
            
            const SizedBox(height: 20),
            
            // Swap Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => provider.swapUnits(),
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Swap Units'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // To Unit Section
            _buildUnitSelector(
              label: 'To',
              selectedUnit: provider.toUnit,
              units: provider.availableUnits,
              onChanged: (unit) => provider.setToUnit(unit),
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSelector({
    required String label,
    required UnitModel? selectedUnit,
    required List<UnitModel> units,
    required ValueChanged<UnitModel?> onChanged,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<UnitModel>(
          value: selectedUnit,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF4A5568) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items: units.map((unit) {
            return DropdownMenuItem<UnitModel>(
              value: unit,
              child: Text('${unit.name} (${unit.symbol})'),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildResultDisplay(ConverterProvider provider, bool isDarkMode) {
    final resultText = provider.formattedResult;
    final symbol = provider.toUnit?.symbol ?? '';
    
    return Card(
      elevation: 8,
      shadowColor: isDarkMode ? Colors.black45 : Colors.grey,
      color: isDarkMode ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Result',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    resultText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.blue[300] : Colors.blue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (symbol.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  Text(
                    symbol,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _copyToClipboard,
              icon: const Icon(Icons.copy),
              label: const Text('Copy to Clipboard'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

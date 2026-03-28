import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import '../providers/converter_provider.dart';

/// Conversion Card Widget - Main conversion input/output display
class ConversionCard extends StatelessWidget {
  const ConversionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConverterProvider>(context);
    final isDarkMode = provider.isDarkMode;
    final primaryColor = provider.getCurrentColor();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // From Unit Section
          _buildUnitSection(
            context,
            label: 'From',
            unit: provider.fromUnit,
            value: provider.inputValue,
            onChanged: (value) => provider.setInputValue(value),
            onUnitSelected: (unit) => provider.setFromUnit(unit),
            isDarkMode: isDarkMode,
            primaryColor: primaryColor,
            isInput: true,
          ),
          
          const SizedBox(height: 16),
          
          // Swap Button
          _buildSwapButton(provider, primaryColor, isDarkMode),
          
          const SizedBox(height: 16),
          
          // To Unit Section
          _buildUnitSection(
            context,
            label: 'To',
            unit: provider.toUnit,
            value: provider.getFormattedResult(),
            onChanged: null,
            onUnitSelected: (unit) => provider.setToUnit(unit),
            isDarkMode: isDarkMode,
            primaryColor: primaryColor,
            isInput: false,
            showCopyButton: true,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSection(
    BuildContext context, {
    required String label,
    required dynamic unit,
    required String value,
    Function(String)? onChanged,
    Function(dynamic)? onUnitSelected,
    required bool isDarkMode,
    required Color primaryColor,
    required bool isInput,
    bool showCopyButton = false,
  }) {
    final provider = Provider.of<ConverterProvider>(context);
    final units = provider.availableUnits;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withOpacity(0.3) 
                : Colors.grey.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with label and unit dropdown
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _buildUnitDropdown(
                  context,
                  units: units,
                  selectedUnit: unit,
                  onSelected: onUnitSelected,
                  isDarkMode: isDarkMode,
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ),
          
          // Input/Output field
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: isInput
                      ? TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*\.?\d*'),
                            ),
                          ],
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.grey[600] : Colors.grey[300],
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: onChanged,
                        )
                      : Text(
                          value,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                ),
                if (showCopyButton && value != '---') ...[
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      FlutterClipboard.copy(value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard!'),
                          backgroundColor: primaryColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.copy_rounded,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitDropdown(
    BuildContext context, {
    required List<dynamic> units,
    required dynamic selectedUnit,
    Function(dynamic)? onSelected,
    required bool isDarkMode,
    required Color primaryColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          value: selectedUnit,
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: primaryColor,
          ),
          dropdownColor: isDarkMode ? const Color(0xFF2D2D2D) : Colors.white,
          items: units.map((unit) {
            return DropdownMenuItem(
              value: unit,
              child: Text(
                unit.symbol,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              HapticFeedback.lightImpact();
              onSelected?.call(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSwapButton(
    ConverterProvider provider,
    Color primaryColor,
    bool isDarkMode,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        provider.swapUnits();
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor,
              primaryColor.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.swap_vert_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}

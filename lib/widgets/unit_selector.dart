import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../providers/converter_provider.dart';

class UnitSelector extends StatelessWidget {
  final String label;
  final bool isFromUnit;

  const UnitSelector({
    Key? key,
    required this.label,
    required this.isFromUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final converter = Provider.of<ConverterProvider>(context);
    final isDark = converter.isDarkMode;
    final units = converter.currentUnits;
    final selectedIndex = isFromUnit ? converter.fromUnitIndex : converter.toUnitIndex;
    final selectedUnit = units[selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFFA0AEC0) : const Color(0xFF718096),
          ),
        ),
        const SizedBox(height: 8),
        Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            depth: 4,
            lightSource: LightSource.topLeft,
            color: isDark ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<int>(
                value: selectedIndex,
                isExpanded: true,
                dropdownColor: isDark ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
                style: TextStyle(
                  color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF2D3748),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: isDark ? const Color(0xFF667EEA) : const Color(0xFF667EEA),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                borderRadius: BorderRadius.circular(15),
                items: units.asMap().entries.map((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Icon(
                          entry.value.icon,
                          size: 20,
                          color: isDark ? const Color(0xFF667EEA) : const Color(0xFF667EEA),
                        ),
                        const SizedBox(width: 8),
                        Text('${entry.value.name} (${entry.value.symbol})'),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    if (isFromUnit) {
                      converter.setFromUnit(value);
                    } else {
                      converter.setToUnit(value);
                    }
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

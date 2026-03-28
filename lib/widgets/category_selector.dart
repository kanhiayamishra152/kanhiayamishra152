import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';
import '../utils/unit_data_provider.dart';

/// Category Selector Widget - Horizontal scrollable category cards
class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConverterProvider>(context);
    final isDarkMode = provider.isDarkMode;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: UnitCategory.values.length,
        itemBuilder: (context, index) {
          final category = UnitCategory.values[index];
          final isSelected = provider.selectedCategory == category;
          final color = UnitDataProvider.getCategoryColor(category, isDarkMode);
          final icon = UnitDataProvider.getCategoryIcon(category);
          final name = UnitDataProvider.getCategoryName(category);

          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              provider.setCategory(category);
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? color : (isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : isDarkMode
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? Colors.white : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name.split(' ')[0],
                    style: TextStyle(
                      color: isSelected ? Colors.white : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

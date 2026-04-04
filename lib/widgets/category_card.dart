import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../models/unit_models.dart';
import '../providers/converter_provider.dart';

class CategoryCard extends StatelessWidget {
  final UnitCategory category;
  final String title;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.title,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final converter = Provider.of<ConverterProvider>(context);
    final isSelected = converter.selectedCategory == category;
    final isDark = converter.isDarkMode;

    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
        depth: isSelected ? -8 : 4,
        lightSource: LightSource.topLeft,
        color: isDark ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            converter.setCategory(category);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: isSelected
                  ? LinearGradient(
                      colors: [gradientStart, gradientEnd],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: isSelected ? Colors.white : (isDark ? const Color(0xFFA0AEC0) : const Color(0xFF718096)),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF4A5568)),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

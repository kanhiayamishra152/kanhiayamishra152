import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/converter_provider.dart';
import '../widgets/category_selector.dart';
import '../widgets/conversion_card.dart';
import '../widgets/theme_toggle.dart';

/// Home Screen - Main converter interface
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConverterProvider>(context);
    final isDarkMode = provider.isDarkMode;
    final categoryName = provider.selectedCategory.toString().split('.').last;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, isDarkMode),
            
            const SizedBox(height: 24),
            
            // Category Selector
            const CategorySelector(),
            
            const SizedBox(height: 24),
            
            // Category Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Icon(
                    provider.selectedCategory == UnitCategory.weight
                        ? Icons.scale
                        : provider.selectedCategory == UnitCategory.length
                            ? Icons.straighten
                            : provider.selectedCategory == UnitCategory.volume
                                ? Icons.water_drop
                                : provider.selectedCategory == UnitCategory.temperature
                                    ? Icons.thermostat
                                    : provider.selectedCategory == UnitCategory.area
                                        ? Icons.square_foot
                                        : Icons.speed,
                    color: provider.getCurrentColor(),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _getCategoryDisplayName(provider.selectedCategory),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Conversion Card
            Expanded(
              child: const ConversionCard(),
            ),
            
            // Footer info
            _buildFooter(isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unit Converter',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                'Convert anything, anytime',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ],
          ),
          const ThemeToggle(),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(UnitCategory category) {
    switch (category) {
      case UnitCategory.weight:
        return 'Weight & Mass';
      case UnitCategory.length:
        return 'Length & Distance';
      case UnitCategory.volume:
        return 'Volume & Capacity';
      case UnitCategory.temperature:
        return 'Temperature';
      case UnitCategory.area:
        return 'Area';
      case UnitCategory.speed:
        return 'Speed';
    }
  }

  Widget _buildFooter(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        'High precision conversion up to 10 decimal places',
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/converter_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/unit_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final converter = Provider.of<ConverterProvider>(context);
    final isDark = converter.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with theme toggle
              _buildHeader(context, converter),
              const SizedBox(height: 30),
              
              // Category title
              Text(
                'Select Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 16),
              
              // Category grid
              _buildCategoryGrid(),
              const SizedBox(height: 30),
              
              // Converter section
              _buildConverterSection(context, converter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ConverterProvider converter) {
    final isDark = converter.isDarkMode;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unit Converter',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Convert anything, anytime',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? const Color(0xFFA0AEC0) : const Color(0xFF718096),
              ),
            ),
          ],
        ),
        Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.circle(),
            depth: 4,
            lightSource: LightSource.topLeft,
            color: isDark ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => converter.toggleTheme(),
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                  size: 20,
                  color: isDark ? const Color(0xFFFFD700) : const Color(0xFF667EEA),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: const [
        CategoryCard(
          category: UnitCategory.weight,
          title: 'Weight & Mass',
          icon: FontAwesomeIcons.weightHanging,
          gradientStart: Color(0xFF667EEA),
          gradientEnd: Color(0xFF764BA2),
        ),
        CategoryCard(
          category: UnitCategory.length,
          title: 'Length',
          icon: FontAwesomeIcons.ruler,
          gradientStart: Color(0xFF56CCF2),
          gradientEnd: Color(0xFF2F80ED),
        ),
        CategoryCard(
          category: UnitCategory.volume,
          title: 'Volume',
          icon: FontAwesomeIcons.flask,
          gradientStart: Color(0xFF11998E),
          gradientEnd: Color(0xFF38EF7D),
        ),
        CategoryCard(
          category: UnitCategory.temperature,
          title: 'Temperature',
          icon: FontAwesomeIcons.thermometerHalf,
          gradientStart: Color(0xFFEB3349),
          gradientEnd: Color(0xFFF45C43),
        ),
        CategoryCard(
          category: UnitCategory.area,
          title: 'Area',
          icon: FontAwesomeIcons.thLarge,
          gradientStart: Color(0xFF8E2DE2),
          gradientEnd: Color(0xFF4A00E0),
        ),
        CategoryCard(
          category: UnitCategory.speed,
          title: 'Speed',
          icon: FontAwesomeIcons.tachometerAlt,
          gradientStart: Color(0xFFFC4A1A),
          gradientEnd: Color(0xFFF7B733),
        ),
      ],
    );
  }

  Widget _buildConverterSection(BuildContext context, ConverterProvider converter) {
    final isDark = converter.isDarkMode;
    
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
        depth: 8,
        lightSource: LightSource.topLeft,
        color: isDark ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // From Unit Selector
            UnitSelector(label: 'From', isFromUnit: true),
            const SizedBox(height: 24),
            
            // Swap Button
            _buildSwapButton(converter),
            const SizedBox(height: 24),
            
            // To Unit Selector
            UnitSelector(label: 'To', isFromUnit: false),
            const SizedBox(height: 24),
            
            // Input Field
            _buildInputField(converter, isDark),
            const SizedBox(height: 24),
            
            // Result Display
            _buildResultDisplay(converter, isDark),
            const SizedBox(height: 16),
            
            // Copy Button
            _buildCopyButton(context, converter, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSwapButton(ConverterProvider converter) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.circle(),
        depth: 4,
        lightSource: LightSource.topLeft,
        color: converter.isDarkMode ? const Color(0xFF2D3748) : const Color(0xFFF5F7FA),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            converter.swapUnits();
          },
          borderRadius: BorderRadius.circular(30),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.swap_vert_rounded,
              size: 28,
              color: Color(0xFF667EEA),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(ConverterProvider converter, bool isDark) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
        lightSource: LightSource.topLeft,
        color: isDark ? const Color(0xFF1A202C) : const Color(0xFFFFFFFF),
      ),
      child: TextField(
        onChanged: (value) {
          converter.setInputValue(value);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
        ],
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF2D3748),
        ),
        decoration: InputDecoration(
          hintText: 'Enter value',
          hintStyle: TextStyle(
            color: isDark ? const Color(0xFF4A5568) : const Color(0xFFA0AEC0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: Icon(
            Icons.edit,
            color: isDark ? const Color(0xFF667EEA) : const Color(0xFF667EEA),
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay(ConverterProvider converter, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667EEA).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Result',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            converter.getFormattedResult(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            converter.toUnit.symbol,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyButton(BuildContext context, ConverterProvider converter, bool isDark) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 0,
        color: const Color(0xFF667EEA),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            HapticFeedback.lightImpact();
            await converter.copyToClipboard();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Copied to clipboard!'),
                  backgroundColor: const Color(0xFF11998E),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.copy_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Copy Result',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

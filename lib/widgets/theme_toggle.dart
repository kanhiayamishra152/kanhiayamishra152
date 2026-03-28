import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';

/// Theme Toggle Widget - Light/Dark mode switch
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConverterProvider>(context);
    final isDarkMode = provider.isDarkMode;

    return GestureDetector(
      onTap: () {
        provider.toggleDarkMode();
      },
      child: Container(
        width: 60,
        height: 32,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDarkMode ? const Color(0xFF333333) : const Color(0xFFCCCCCC),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isDarkMode ? 30 : 2,
              top: 2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? [const Color(0xFF424242), const Color(0xFF616161)]
                        : [const Color(0xFFFFD54F), const Color(0xFFFFCA28)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  size: 16,
                  color: isDarkMode ? Colors.white : const Color(0xFF5D4037),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

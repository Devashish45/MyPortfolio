import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    
    // Columns: 1 for mobile, 2 for tablet, 3 for desktop
    final int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1152.0),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Headers
          Center(
            child: Column(
              children: [
                Text(
                  AppStrings.arsenalHeader,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  AppStrings.arsenalSubHeader,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48.0),
          
          // Cards Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: isMobile ? 1.7 : 1.4,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            children: const [
              _TechCard(
                title: AppStrings.techCategory1,
                icon: Icons.android,
                skills: ['Kotlin', 'Java', 'Jetpack Compose', 'Coroutines'],
                isCyanTheme: true,
              ),
              _TechCard(
                title: AppStrings.techCategory2,
                icon: Icons.flutter_dash,
                skills: ['Flutter / Dart', 'Bloc', 'Riverpod', 'KMP'],
                isCyanTheme: false,
              ),
              _TechCard(
                title: AppStrings.techCategory3,
                icon: Icons.architecture,
                skills: ['Dagger Hilt', 'Koin', 'Clean Architecture', 'MVVM'],
                isCyanTheme: true,
              ),
              _TechCard(
                title: AppStrings.techCategory4,
                icon: Icons.network_ping,
                skills: ['Retrofit', 'Ktor', 'GraphQL', 'WebSockets'],
                isCyanTheme: false,
              ),
              _TechCard(
                title: AppStrings.techCategory5,
                icon: Icons.storage,
                skills: ['Room', 'Realm', 'SQLite', 'Hive'],
                isCyanTheme: true,
              ),
              _TechCard(
                title: AppStrings.techCategory6,
                icon: Icons.settings_suggest,
                skills: ['Firebase', 'Bitrise', 'Jenkins', 'Git'],
                isCyanTheme: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> skills;
  final bool isCyanTheme;

  const _TechCard({
    required this.title,
    required this.icon,
    required this.skills,
    required this.isCyanTheme,
  });

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isCyanTheme ? AppColors.primary : AppColors.secondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.diagonal3Values(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: _isHovered ? themeColor.withValues(alpha: 0.5) : AppColors.outlineVariant,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: themeColor.withValues(alpha: _isHovered ? 0.15 : 0.0),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Icon wrapper with glow background
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(
                    widget.icon,
                    color: themeColor,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            
            // Skills tags
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.skills.map((skill) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: AppColors.outlineVariant,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Text(
                    skill,
                    style: AppTheme.codeStyle(
                      fontSize: 12,
                      color: AppColors.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

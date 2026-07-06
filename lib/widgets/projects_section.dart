import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    // Grid layout: 1 column for mobile, 2 for tablet, 3 for desktop
    final int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1152.0),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with Title and "View all" link
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.worksHeader,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                AppStrings.worksSubHeader,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 48.0),
          
          // Projects Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: isMobile ? 0.95 : 0.85,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            children: const [
              _ProjectCard(
                title: AppStrings.proj1Title,
                description: AppStrings.proj1Desc,
                platform: AppStrings.proj1Platform,
                imageUrl: AppStrings.proj1ImageUrl,
                tags: AppStrings.proj1Tags,
                isCyanTheme: true,
              ),
              _ProjectCard(
                title: AppStrings.proj2Title,
                description: AppStrings.proj2Desc,
                platform: AppStrings.proj2Platform,
                imageUrl: AppStrings.proj2ImageUrl,
                tags: AppStrings.proj2Tags,
                isCyanTheme: false,
              ),
              _ProjectCard(
                title: AppStrings.proj3Title,
                description: AppStrings.proj3Desc,
                platform: AppStrings.proj3Platform,
                imageUrl: AppStrings.proj3ImageUrl,
                tags: AppStrings.proj3Tags,
                isCyanTheme: true,
              ),
            ],
          ),
          

        ],
      ),
    );
  }
}



class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String platform;
  final String imageUrl;
  final List<String> tags;
  final bool isCyanTheme;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.platform,
    required this.imageUrl,
    required this.tags,
    required this.isCyanTheme,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isCyanTheme ? AppColors.primary : AppColors.secondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: _isHovered ? themeColor : AppColors.outlineVariant,
            width: 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: themeColor.withValues(alpha: 0.05),
                blurRadius: 25.0,
                spreadRadius: 2.0,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cover Image Area
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: _isHovered ? 1.06 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    
                    // Platform Tag Badge
                    Positioned(
                      top: 16.0,
                      right: 16.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(99.0),
                          border: Border.all(
                            color: themeColor.withValues(alpha: 0.3),
                            width: 1.0,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        child: Text(
                          widget.platform,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: themeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Project Content Area
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.5,
                                ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      
                      // Tag row
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: widget.tags.map((tag) {
                          return Text(
                            tag,
                            style: AppTheme.codeStyle(
                              fontSize: 12.0,
                              color: themeColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

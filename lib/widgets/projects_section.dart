import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../portfolio_urls.dart';

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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 40.0),
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
                tags: AppStrings.proj1Tags,
                isCyanTheme: true,
                androidUrl: PortfolioUrls.proj1Android,
                iosUrl: PortfolioUrls.proj1Ios,
                webUrl: PortfolioUrls.proj1Web,
              ),
              _ProjectCard(
                title: AppStrings.proj2Title,
                description: AppStrings.proj2Desc,
                platform: AppStrings.proj2Platform,
                tags: AppStrings.proj2Tags,
                isCyanTheme: false,
                androidUrl: PortfolioUrls.proj2Android,
              ),
              _ProjectCard(
                title: AppStrings.proj3Title,
                description: AppStrings.proj3Desc,
                platform: AppStrings.proj3Platform,
                tags: AppStrings.proj3Tags,
                isCyanTheme: true,
                androidUrl: PortfolioUrls.proj3Android,
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
  final List<String> tags;
  final bool isCyanTheme;

  final String? androidUrl;
  final String? iosUrl;
  final String? webUrl;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.platform,
    required this.tags,
    required this.isCyanTheme,
    this.androidUrl,
    this.iosUrl,
    this.webUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isCyanTheme
        ? AppColors.primary
        : AppColors.secondary;

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
                flex: 4,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: _isHovered ? 1.06 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.surfaceContainerHigh,
                                AppColors.surfaceContainer,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              _getProjectIcon(widget.title),
                              color: themeColor,
                              size: 48.0,
                            ),
                          ),
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
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.description,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.5,
                                ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const Divider(
                            color: AppColors.outlineVariant,
                            height: 16.0,
                            thickness: 1.0,
                          ),
                          Row(
                            children: [
                              if (widget.androidUrl != null)
                                _ActionLink(
                                  icon: Icons.android,
                                  label: 'View on Android',
                                  color: AppColors.secondary,
                                  url: widget.androidUrl!,
                                ),
                              if (widget.androidUrl != null &&
                                  widget.iosUrl != null)
                                const SizedBox(width: 16.0),
                              if (widget.iosUrl != null)
                                _ActionLink(
                                  icon: Icons.apple,
                                  label: 'View on iOS',
                                  color: AppColors.primary,
                                  url: widget.iosUrl!,
                                ),
                              if (widget.iosUrl != null &&
                                  widget.webUrl != null)
                                const SizedBox(width: 16.0),
                              if (widget.webUrl != null)
                                _ActionLink(
                                  icon: Icons.language,
                                  label: 'View on Web',
                                  color: AppColors.secondary,
                                  url: widget.webUrl!,
                                ),
                            ],
                          ),
                        ],
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

  IconData _getProjectIcon(String title) {
    if (title.contains('TataNeu')) {
      return Icons.widgets;
    } else if (title.contains('Luxury')) {
      return Icons.shopping_bag;
    } else if (title.contains('Fashion')) {
      return Icons.checkroom;
    }
    return Icons.work;
  }
}

class _ActionLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String url;

  const _ActionLink({
    required this.icon,
    required this.label,
    required this.color,
    required this.url,
  });

  @override
  State<_ActionLink> createState() => _ActionLinkState();
}

class _ActionLinkState extends State<_ActionLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Tooltip(
          message: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              widget.icon,
              size: 20.0,
              color: _isHovered
                  ? (widget.color == AppColors.primary
                        ? AppColors.secondary
                        : AppColors.primary)
                  : widget.color,
            ),
          ),
        ),
      ),
    );
  }
}

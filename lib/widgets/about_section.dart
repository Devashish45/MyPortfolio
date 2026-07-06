import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1152.0),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 40.0),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _ProfileImageCard(),
                const SizedBox(height: 48.0),
                _buildContent(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(flex: 5, child: _ProfileImageCard()),
                const SizedBox(width: 64.0),
                Expanded(flex: 7, child: _buildContent(context)),
              ],
            ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text(
          AppStrings.aboutHeader,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.primary,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          AppStrings.aboutSubHeader,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 24.0),

        // Bio Text
        Text(
          AppStrings.aboutBio,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32.0),

        // Info Grid
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.outlineVariant, width: 1.0),
            ),
          ),
          padding: const EdgeInsets.only(top: 32.0),
          child: const Wrap(
            spacing: 32.0,
            runSpacing: 24.0,
            children: [
              _InfoBlock(
                label: AppStrings.aboutDetailLocationLabel,
                value: AppStrings.aboutDetailLocationValue,
              ),
              _InfoBlock(
                label: AppStrings.aboutDetailRoleLabel,
                value: AppStrings.aboutDetailRoleValue,
              ),
              _InfoBlock(
                label: AppStrings.aboutDetailDegreeLabel,
                value: AppStrings.aboutDetailDegreeValue,
              ),
              _InfoBlock(
                label: AppStrings.aboutDetailLangLabel,
                value: AppStrings.aboutDetailLangValue,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),

        // Achievements Highlight
        Wrap(
          spacing: 16.0,
          runSpacing: 12.0,
          children: [
            _buildAchievementBadge(
              context,
              icon: Icons.stars,
              text: AppStrings.achievement1Text,
              color: AppColors.primary,
            ),
            _buildAchievementBadge(
              context,
              icon: Icons.emoji_events,
              text: AppStrings.achievement2Text,
              color: AppColors.secondary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.0),
          const SizedBox(width: 8.0),
          Text(
            text.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _ProfileImageCard extends StatefulWidget {
  const _ProfileImageCard();

  @override
  State<_ProfileImageCard> createState() => _ProfileImageCardState();
}

class _ProfileImageCardState extends State<_ProfileImageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.outlineVariant,
              width: 1.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23.0),
            child: Stack(
              children: [
                // Profile Image with Animated Color Filter
                Positioned.fill(
                  child: AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    child: Image.asset(
                      AppStrings.aboutPhotoAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Floating Badge
                Positioned(
                  bottom: 24.0,
                  left: 24.0,
                  right: 24.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  AppStrings.aboutRankLabel,
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(
                                        color: AppColors.secondary,
                                        fontSize: 10,
                                      ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  AppStrings.aboutRankValue,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.workspace_premium,
                              color: AppColors.secondary,
                              size: 32.0,
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    // Force info blocks to take half width on larger screens or stack naturally
    return SizedBox(
      width: 260.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

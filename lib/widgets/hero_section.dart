import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';
import 'ide_mockup.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onTalkTap;
  final VoidCallback onProjectsTap;

  const HeroSection({
    super.key,
    required this.onTalkTap,
    required this.onProjectsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    
    return Container(
      constraints: const BoxConstraints(maxWidth: 1152.0),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 40.0,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildContent(context, isMobile: true),
                const SizedBox(height: 48.0),
                const _MockupWithGlow(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 12,
                  child: _buildContent(context, isMobile: false),
                ),
                const SizedBox(width: 48.0),
                const Expanded(
                  flex: 10,
                  child: _MockupWithGlow(),
                ),
              ],
            ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Available Badge
        const _AvailableBadge(),
        const SizedBox(height: 24.0),
        
        // Headline
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 32 : 48,
                  height: 1.15,
                ),
            children: const [
              TextSpan(text: AppStrings.heroTitleStart),
              TextSpan(
                text: AppStrings.heroTitleName,
                style: TextStyle(color: AppColors.primary),
              ),
              TextSpan(text: AppStrings.heroTitleMiddle),
              TextSpan(
                text: AppStrings.heroTitleEnd,
                style: TextStyle(color: AppColors.secondary),
              ),
              TextSpan(text: AppStrings.heroTitlePostEnd),
              TextSpan(text: "."),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        
        // Description
        Text(
          AppStrings.heroDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 16 : 18,
              ),
        ),
        const SizedBox(height: 32.0),
        
        // Stats Grid
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStat(context, AppStrings.heroStatYrsValue, AppStrings.heroStatYrsLabel, isMobile),
            _buildStat(context, AppStrings.heroStatAppsValue, AppStrings.heroStatAppsLabel, isMobile),
            _buildStat(context, AppStrings.heroStatCrashValue, AppStrings.heroStatCrashLabel, isMobile),
          ],
        ),
        const SizedBox(height: 40.0),
        
        // Actions Buttons
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: [
            _HeroActionButton(
              text: AppStrings.heroButtonTalk,
              icon: Icons.send,
              isPrimary: true,
              onPressed: onTalkTap,
            ),
            _HeroActionButton(
              text: AppStrings.heroButtonProjects,
              isPrimary: false,
              onPressed: onProjectsTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(BuildContext context, String value, String label, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.primary,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4.0),
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 11,
              ),
        ),
      ],
    );
  }
}

class _AvailableBadge extends StatefulWidget {
  const _AvailableBadge();

  @override
  State<_AvailableBadge> createState() => _AvailableBadgeState();
}

class _AvailableBadgeState extends State<_AvailableBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _pulseAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.05),
            blurRadius: 10.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulse Green Indicator
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 1.0 - _pulseAnimation.value),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 8.0),
          const Text(
            AppStrings.heroBadgeText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockupWithGlow extends StatelessWidget {
  const _MockupWithGlow();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background glow
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 60.0,
                  spreadRadius: 10.0,
                ),
                BoxShadow(
                  color: AppColors.secondary.withValues(alpha: 0.08),
                  blurRadius: 60.0,
                  spreadRadius: 10.0,
                ),
              ],
            ),
          ),
        ),
        const IDEMockup(),
      ],
    );
  }
}

class _HeroActionButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _HeroActionButton({
    required this.text,
    this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_HeroActionButton> createState() => _HeroActionButtonState();
}

class _HeroActionButtonState extends State<_HeroActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.diagonal3Values(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovered ? AppColors.primary.withValues(alpha: 0.9) : AppColors.primary)
                : (_isHovered ? AppColors.surfaceContainerHigh : Colors.transparent),
            borderRadius: BorderRadius.circular(12.0),
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: _isHovered ? Colors.white : AppColors.outlineVariant,
                    width: 1.0,
                  ),
            boxShadow: widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: _isHovered ? 0.35 : 0.2),
                      blurRadius: _isHovered ? 25.0 : 15.0,
                      spreadRadius: _isHovered ? 2.0 : 0.0,
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: widget.isPrimary ? const Color(0xFF00363E) : AppColors.onBackground,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8.0),
                Icon(
                  widget.icon,
                  size: 18.0,
                  color: widget.isPrimary ? const Color(0xFF00363E) : AppColors.onBackground,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

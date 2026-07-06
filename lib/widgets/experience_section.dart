import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 1152.0),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Headers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.expHeader,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                AppStrings.expSubHeader,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 64.0),
          
          // Timeline Layout
          isMobile ? _buildMobileTimeline() : _buildDesktopTimeline(),
        ],
      ),
    );
  }

  Widget _buildDesktopTimeline() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Center Gradient Line
        Positioned(
          top: 0,
          bottom: 0,
          child: Container(
            width: 2.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        
        // Timeline items
        Column(
          children: [
            // Block 1
            _buildTimelineRow(
              isLeft: true,
              child: const _ExperienceCard(
                role: AppStrings.exp1Role,
                company: AppStrings.exp1Company,
                period: AppStrings.exp1Period,
                bulletPoints: AppStrings.exp1Points,
                isCyanTheme: true,
              ),
            ),
            const SizedBox(height: 48.0),
            // Block 2
            _buildTimelineRow(
              isLeft: false,
              child: const _ExperienceCard(
                role: AppStrings.exp2Role,
                company: AppStrings.exp2Company,
                period: AppStrings.exp2Period,
                bulletPoints: AppStrings.exp2Points,
                isCyanTheme: false,
              ),
            ),
            const SizedBox(height: 48.0),
            // Block 3
            _buildTimelineRow(
              isLeft: true,
              child: const _ExperienceCard(
                role: AppStrings.exp3Role,
                company: AppStrings.exp3Company,
                period: AppStrings.exp3Period,
                description: AppStrings.exp3Description,
                isCyanTheme: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineRow({required bool isLeft, required Widget child}) {
    return Row(
      children: [
        // Left side
        Expanded(
          child: isLeft
              ? child
              : const SizedBox.shrink(),
        ),
        
        // Dot spacer in the center
        Container(
          width: 40.0,
          alignment: Alignment.center,
          child: _TimelineDot(isCyan: isLeft),
        ),
        
        // Right side
        Expanded(
          child: !isLeft
              ? child
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMobileTimeline() {
    return Stack(
      children: [
        // Left aligned vertical line
        Positioned(
          left: 19.0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        
        Column(
          children: [
            // Block 1
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Center(child: _TimelineDot(isCyan: true)),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: const _ExperienceCard(
                    role: AppStrings.exp1Role,
                    company: AppStrings.exp1Company,
                    period: AppStrings.exp1Period,
                    bulletPoints: AppStrings.exp1Points,
                    isCyanTheme: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            // Block 2
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Center(child: _TimelineDot(isCyan: false)),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: const _ExperienceCard(
                    role: AppStrings.exp2Role,
                    company: AppStrings.exp2Company,
                    period: AppStrings.exp2Period,
                    bulletPoints: AppStrings.exp2Points,
                    isCyanTheme: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            // Block 3
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Center(child: _TimelineDot(isCyan: true)),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: const _ExperienceCard(
                    role: AppStrings.exp3Role,
                    company: AppStrings.exp3Company,
                    period: AppStrings.exp3Period,
                    description: AppStrings.exp3Description,
                    isCyanTheme: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final bool isCyan;

  const _TimelineDot({required this.isCyan});

  @override
  Widget build(BuildContext context) {
    final themeColor = isCyan ? AppColors.primary : AppColors.secondary;
    
    return Container(
      width: 18.0,
      height: 18.0,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: themeColor,
          width: 3.0,
        ),
        boxShadow: [
          BoxShadow(
            color: themeColor.withValues(alpha: 0.5),
            blurRadius: 8.0,
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final String role;
  final String company;
  final String period;
  final List<String>? bulletPoints;
  final String? description;
  final bool isCyanTheme;

  const _ExperienceCard({
    required this.role,
    required this.company,
    required this.period,
    this.bulletPoints,
    this.description,
    required this.isCyanTheme,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isCyanTheme ? AppColors.primary : AppColors.secondary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: _isHovered ? themeColor : AppColors.outlineVariant,
            width: 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: themeColor.withValues(alpha: 0.05),
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ),
          ],
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.role,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.company,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  widget.period,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            
            // Bullet Points
            if (widget.bulletPoints != null && widget.bulletPoints!.isNotEmpty)
              Column(
                children: widget.bulletPoints!.map((point) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 12.0),
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              color: themeColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            
            // Description (e.g. for DRPU Software)
            if (widget.description != null && widget.description!.isNotEmpty)
              Text(
                widget.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}

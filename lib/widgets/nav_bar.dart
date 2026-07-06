import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavItemTap;
  final VoidCallback onResumeTap;

  const NavBar({
    super.key,
    required this.onNavItemTap,
    required this.onResumeTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          height: 64.0,
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.4),
            border: const Border(
              bottom: BorderSide(
                color: AppColors.outlineVariant,
                width: 1.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 40.0,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1152.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => onNavItemTap(0), // Scroll to top
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        AppStrings.logoText,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  
                  // Menu Items (Desktop)
                  if (!isMobile)
                    Row(
                      children: [
                        _NavBarLink(text: AppStrings.navAbout, onTap: () => onNavItemTap(1)),
                        const SizedBox(width: 32),
                        _NavBarLink(text: AppStrings.navStack, onTap: () => onNavItemTap(2)),
                        const SizedBox(width: 32),
                        _NavBarLink(text: AppStrings.navExperience, onTap: () => onNavItemTap(3)),
                        const SizedBox(width: 32),
                        _NavBarLink(text: AppStrings.navProjects, onTap: () => onNavItemTap(4)),
                        const SizedBox(width: 32),
                        _ResumeButton(onPressed: onResumeTap),
                      ],
                    )
                  else
                    // Mobile Drawer Trigger
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavBarLink({
    required this.text,
    required this.onTap,
  });

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.0,
            color: _isHovered ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _ResumeButton({required this.onPressed});

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary.withValues(alpha: 0.9) : AppColors.primary,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _isHovered ? 0.35 : 0.2),
              blurRadius: _isHovered ? 25.0 : 15.0,
              spreadRadius: _isHovered ? 2.0 : 0.0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: widget.onPressed,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Text(
                AppStrings.navResumeButton,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00363E), // on-primary
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

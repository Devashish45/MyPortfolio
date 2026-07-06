import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/download_helper.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1152.0),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 40.0,
          ),
          child: isMobile
              ? Column(
                  children: [
                    Text(
                      AppStrings.logoText,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      AppStrings.footerCopyright,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _FooterLink(
                          text: AppStrings.footerGithub,
                          onTap: () => launchUrl(Uri.parse('https://github.com/devashish-singh')),
                        ),
                        const SizedBox(width: 24.0),
                        _FooterLink(
                          text: AppStrings.footerLinkedIn,
                          onTap: () => launchUrl(Uri.parse('https://linkedin.com/in/devashish-singh')),
                        ),
                        const SizedBox(width: 24.0),
                        _FooterLink(
                          text: AppStrings.footerResume,
                          onTap: () {
                            downloadResume(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.logoText,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      AppStrings.footerCopyright,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                    Row(
                      children: [
                        _FooterLink(
                          text: AppStrings.footerGithub,
                          onTap: () => launchUrl(Uri.parse('https://github.com/devashish-singh')),
                        ),
                        const SizedBox(width: 24.0),
                        _FooterLink(
                          text: AppStrings.footerLinkedIn,
                          onTap: () => launchUrl(Uri.parse('https://linkedin.com/in/devashish-singh')),
                        ),
                        const SizedBox(width: 24.0),
                        _FooterLink(
                          text: AppStrings.footerResume,
                          onTap: () {
                            downloadResume(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({required this.text, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
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
            fontSize: 14.0,
            color: _isHovered ? AppColors.secondary : AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

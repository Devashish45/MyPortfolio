import 'package:flutter/material.dart';
import '../theme.dart';
import '../responsive_layout.dart';
import '../strings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../portfolio_urls.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
                _buildInfo(context),
                const SizedBox(height: 48.0),
                const _ContactFormCard(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: _buildInfo(context),
                ),
                const SizedBox(width: 64.0),
                const Expanded(
                  flex: 12,
                  child: _ContactFormCard(),
                ),
              ],
            ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headers
        Text(
          AppStrings.contactHeader,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.5,
              ),
        ),
        const SizedBox(height: 8.0),
        Text(
          AppStrings.contactSubHeader,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 24.0),
        
        // Text
        Text(
          AppStrings.contactDescription,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 40.0),
        
        // Quick Links
        Row(
          children: [
            const Icon(Icons.mail, color: AppColors.primary, size: 24.0),
            const SizedBox(width: 16.0),
            Text(
              AppStrings.contactEmail,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                color: AppColors.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Icon(Icons.call, color: AppColors.secondary, size: 24.0),
            const SizedBox(width: 16.0),
            Text(
              AppStrings.contactPhone,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                color: AppColors.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Icon(Icons.school, color: AppColors.primary, size: 24.0),
            const SizedBox(width: 16.0),
            Text(
              AppStrings.contactLocation,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.0,
                color: AppColors.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40.0),
        
        // Social Media Buttons
        Row(
          children: [
            _SocialButton(
              icon: Icons.code, // Stand-in for Github
              label: 'GitHub',
              color: AppColors.primary,
              onPressed: () => launchUrl(Uri.parse(PortfolioUrls.github)),
            ),
            const SizedBox(width: 16.0),
            _SocialButton(
              icon: Icons.business, // Stand-in for LinkedIn
              label: 'LinkedIn',
              color: AppColors.secondary,
              onPressed: () => launchUrl(Uri.parse(PortfolioUrls.linkedin)),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: _isHovered ? widget.color : AppColors.outlineVariant,
              width: 1.0,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.15),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? widget.color : AppColors.onBackground,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}

class _ContactFormCard extends StatefulWidget {
  const _ContactFormCard();

  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  // FocusNodes
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listeners to rebuild when focus changes (to animate glowing outlines)
    _nameFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
    _messageFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _nameFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.removeListener(_onFocusChange);
    _messageFocusNode.removeListener(_onFocusChange);
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: AppColors.outlineVariant,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 30.0,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            _buildField(
              label: AppStrings.contactFieldFullName,
              placeholder: AppStrings.contactPlaceholderFullName,
              controller: _nameController,
              focusNode: _nameFocusNode,
              isCyanTheme: true,
              maxLines: 1,
            ),
            const SizedBox(height: 24.0),
            
            // Email Field
            _buildField(
              label: AppStrings.contactFieldEmail,
              placeholder: AppStrings.contactPlaceholderEmail,
              controller: _emailController,
              focusNode: _emailFocusNode,
              isCyanTheme: false,
              maxLines: 1,
            ),
            const SizedBox(height: 24.0),
            
            // Message Field
            _buildField(
              label: AppStrings.contactFieldMessage,
              placeholder: AppStrings.contactPlaceholderMessage,
              controller: _messageController,
              focusNode: _messageFocusNode,
              isCyanTheme: true,
              maxLines: 4,
            ),
            const SizedBox(height: 32.0),
            
            // Submit Button
            _SubmitButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.contactSubmitSuccess),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                  _nameController.clear();
                  _emailController.clear();
                  _messageController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isCyanTheme,
    required int maxLines,
  }) {
    final hasFocus = focusNode.hasFocus;
    final themeColor = isCyanTheme ? AppColors.primary : AppColors.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 11,
              ),
        ),
        const SizedBox(height: 8.0),
        
        // Input Wrapper Container with animated focus glow
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: hasFocus ? themeColor : AppColors.outlineVariant,
              width: 1.0,
            ),
            boxShadow: [
              if (hasFocus)
                BoxShadow(
                  color: themeColor.withValues(alpha: 0.15),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15.0,
              color: AppColors.onSurface,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: AppColors.outline,
                fontSize: 15.0,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppStrings.contactValidationEmpty;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _SubmitButton({required this.onPressed});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
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
          transform: Matrix4.diagonal3Values(_isHovered ? 1.01 : 1.0, _isHovered ? 1.01 : 1.0, 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.9) : AppColors.primary,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _isHovered ? 0.35 : 0.2),
                blurRadius: _isHovered ? 25.0 : 15.0,
                spreadRadius: _isHovered ? 2.0 : 0.0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          alignment: Alignment.center,
          child: const Text(
            AppStrings.contactSubmitButton,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00363E), // on-primary
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme.dart';
import '../strings.dart';

class IDEMockup extends StatelessWidget {
  const IDEMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.outlineVariant,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 30.0,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Window Buttons (macOS style)
                const Row(
                  children: [
                    _TerminalDot(color: Color(0xFFEF4444)), // Red
                    SizedBox(width: 8),
                    _TerminalDot(color: Color(0xFFF59E0B)), // Yellow
                    SizedBox(width: 8),
                    _TerminalDot(color: Color(0xFF10B981)), // Green
                  ],
                ),
                // Title
                Text(
                  AppStrings.ideFileName,
                  style: AppTheme.codeStyle(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                // Spacing block to balance the layout
                const SizedBox(width: 52),
              ],
            ),
          ),
          
          // Code Box
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _codeRow([
                    _codeSpan('class ', color: AppColors.secondary),
                    _codeSpan('${AppStrings.ideClassName} ', color: AppColors.primary),
                    _codeSpan('{', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('  val ', color: AppColors.secondary),
                    _codeSpan('role = ', color: Colors.white),
                    _codeSpan('"${AppStrings.ideRoleValue}"', color: const Color(0xFFA7F3D0)),
                  ]),
                  _codeRow([
                    _codeSpan('  val ', color: AppColors.secondary),
                    _codeSpan('skills = ', color: Colors.white),
                    _codeSpan('listOf', color: AppColors.primary),
                    _codeSpan('(', color: Colors.white),
                    _codeSpan('"${AppStrings.ideSkillsValue1}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(', ', color: Colors.white),
                    _codeSpan('"${AppStrings.ideSkillsValue2}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(', ', color: Colors.white),
                    _codeSpan('"${AppStrings.ideSkillsValue3}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(')', color: Colors.white),
                  ]),
                  const SizedBox(height: 16),
                  _codeRow([
                    _codeSpan('  // Delivering high-performance solutions', color: AppColors.onSurfaceVariant),
                  ]),
                  _codeRow([
                    _codeSpan('  fun ', color: AppColors.secondary),
                    _codeSpan('getImpact() {', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('    println', color: AppColors.primary),
                    _codeSpan('(', color: Colors.white),
                    _codeSpan('"${AppStrings.ideImpactValue1}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(')', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('    println', color: AppColors.primary),
                    _codeSpan('(', color: Colors.white),
                    _codeSpan('"${AppStrings.ideImpactValue2}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(')', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('    println', color: AppColors.primary),
                    _codeSpan('(', color: Colors.white),
                    _codeSpan('"${AppStrings.ideImpactValue3}"', color: const Color(0xFFA7F3D0)),
                    _codeSpan(')', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('  }', color: Colors.white),
                  ]),
                  _codeRow([
                    _codeSpan('}', color: Colors.white),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeRow(List<TextSpan> spans) {
    return RichText(
      text: TextSpan(
        style: AppTheme.codeStyle(fontSize: 14),
        children: spans,
      ),
    );
  }

  TextSpan _codeSpan(String text, {required Color color}) {
    return TextSpan(
      text: text,
      style: TextStyle(color: color),
    );
  }
}

class _TerminalDot extends StatelessWidget {
  final Color color;

  const _TerminalDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

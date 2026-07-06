import 'package:flutter/material.dart';
import 'theme.dart';
import 'strings.dart';
import 'widgets/nav_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/tech_stack_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';
import 'utils/download_helper.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppStrings.logoText} | Android & Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  // GlobalKeys for section references
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _techKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Scroll logic
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onNavItemTap(int index) {
    switch (index) {
      case 0:
        _scrollToSection(_heroKey);
        break;
      case 1:
        _scrollToSection(_aboutKey);
        break;
      case 2:
        _scrollToSection(_techKey);
        break;
      case 3:
        _scrollToSection(_experienceKey);
        break;
      case 4:
        _scrollToSection(_projectsKey);
        break;
      case 5:
        _scrollToSection(_contactKey);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      // Floating Header NavBar
      appBar: NavBar(
        onNavItemTap: _onNavItemTap,
        onResumeTap: () {
          downloadResume(context);
        },
      ),
      
      // EndDrawer for Mobile/Tablet viewports
      endDrawer: Drawer(
        backgroundColor: AppColors.surface,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drawer Header logo
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  AppStrings.logoText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Divider(color: AppColors.outlineVariant, height: 1),
              
              // Navigation Items
              _buildDrawerItem(context, AppStrings.navAbout, 1),
              _buildDrawerItem(context, AppStrings.navStack, 2),
              _buildDrawerItem(context, AppStrings.navExperience, 3),
              _buildDrawerItem(context, AppStrings.navProjects, 4),
              _buildDrawerItem(context, AppStrings.navContact, 5),
              
              const Spacer(),
              
              // Call to Action
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: const Color(0xFF00363E),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    downloadResume(context);
                  },
                  child: const Text(
                    AppStrings.navResumeButton,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // Page Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Margin space beneath nav bar
            SizedBox(key: _heroKey, height: 48.0),
            
            // Hero section
            HeroSection(
              onTalkTap: () => _scrollToSection(_contactKey),
              onProjectsTap: () => _scrollToSection(_projectsKey),
            ),
            
            const SizedBox(height: 128.0),
            
            // About section
            Container(
              key: _aboutKey,
              child: const AboutSection(),
            ),
            
            const SizedBox(height: 128.0),
            
            // Arsenal / Tech Stack section
            Container(
              key: _techKey,
              child: const TechStackSection(),
            ),
            
            const SizedBox(height: 128.0),
            
            // Career Path / Experience section
            Container(
              key: _experienceKey,
              child: const ExperienceSection(),
            ),
            
            const SizedBox(height: 128.0),
            
            // Works / Projects section
            Container(
              key: _projectsKey,
              child: const ProjectsSection(),
            ),
            
            const SizedBox(height: 128.0),
            
            // Contact section
            Container(
              key: _contactKey,
              child: const ContactSection(),
            ),
            
            const SizedBox(height: 128.0),
            
            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, int targetIndex) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          color: AppColors.onSurface,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        _onNavItemTap(targetIndex); // Scroll
      },
    );
  }
}

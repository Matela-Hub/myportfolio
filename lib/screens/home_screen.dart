import 'package:flutter/material.dart';
import 'package:myportfolio/screens/sections/hero_section.dart';
import 'package:myportfolio/screens/sections/about_section.dart';
import 'package:myportfolio/screens/sections/skills_education_section.dart';
import 'package:myportfolio/screens/sections/services_section.dart';
import 'package:myportfolio/screens/sections/portfolio_section.dart';
import 'package:myportfolio/screens/sections/contact_section.dart';
import 'package:myportfolio/screens/sections/footer_section.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:myportfolio/constants/theme_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final themeMode = ThemeService.instance.themeMode.value;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile ? _buildDrawer() : null,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: isMobile 
          ? IconButton(
              icon: const Icon(Icons.menu, color: AppColors.accent),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            )
          : null,
        title: const Text('Moshate', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.accent)),
        actions: [
          if (!isMobile) ...[
            _NavButton(text: 'Home', onPressed: () => _scrollToSection(_heroKey)),
            _NavButton(text: 'About', onPressed: () => _scrollToSection(_aboutKey)),
            _NavButton(text: 'Services', onPressed: () => _scrollToSection(_servicesKey)),
            _NavButton(text: 'Portfolio', onPressed: () => _scrollToSection(_portfolioKey)),
            _NavButton(text: 'Contact', onPressed: () => _scrollToSection(_contactKey)),
          ],
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.accent,
            ),
            onPressed: () {
              setState(() {
                ThemeService.instance.toggleTheme();
              });
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(
              key: _heroKey,
              onContactPressed: () => _scrollToSection(_contactKey),
            ),
            AboutSection(key: _aboutKey),
            SkillsEducationSection(key: _skillsKey),
            ServicesSection(key: _servicesKey),
            PortfolioSection(key: _portfolioKey),
            ContactSection(key: _contactKey),
            FooterSection(
              onHomePressed: () => _scrollToSection(_heroKey),
              onAboutPressed: () => _scrollToSection(_aboutKey),
              onServicesPressed: () => _scrollToSection(_servicesKey),
              onPortfolioPressed: () => _scrollToSection(_portfolioKey),
              onContactPressed: () => _scrollToSection(_contactKey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    final themeMode = ThemeService.instance.themeMode.value;
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Moshate',
                  style: TextStyle(color: AppColors.accent, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Portfolio',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14),
                ),
              ],
            ),
          ),
          _DrawerTile(
            title: 'Home', 
            icon: Icons.home, 
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_heroKey);
            }
          ),
          _DrawerTile(
            title: 'About', 
            icon: Icons.person, 
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_aboutKey);
            }
          ),
          _DrawerTile(
            title: 'Services', 
            icon: Icons.settings, 
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_servicesKey);
            }
          ),
          _DrawerTile(
            title: 'Portfolio', 
            icon: Icons.work, 
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_portfolioKey);
            }
          ),
          _DrawerTile(
            title: 'Contact', 
            icon: Icons.contact_mail, 
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(_contactKey);
            }
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              color: AppColors.accent,
            ),
            title: Text(
              themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            onTap: () {
              setState(() {
                ThemeService.instance.toggleTheme();
              });
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<_DrawerTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? AppColors.accent : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.2),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ] : [],
            color: _isHovered 
                ? AppColors.accent.withValues(alpha: 0.05) 
                : Colors.transparent,
          ),
          child: ListTile(
            leading: Icon(
              widget.icon, 
              color: _isHovered ? AppColors.accent : AppColors.accent.withValues(alpha: 0.7),
              size: 22,
            ),
            title: Text(
              widget.title, 
              style: TextStyle(
                color: _isHovered ? AppColors.accent : Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: widget.onTap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _NavButton({required this.text, required this.onPressed});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? AppColors.accent : Colors.transparent,
              width: 1,
            ),
            boxShadow: _isHovered ? [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ] : [],
          ),
          child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              foregroundColor: _isHovered ? AppColors.accent : Theme.of(context).textTheme.bodyLarge?.color,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

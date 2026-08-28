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
            _navButton('Home', () => _scrollToSection(_heroKey)),
            _navButton('About', () => _scrollToSection(_aboutKey)),
            _navButton('Services', () => _scrollToSection(_servicesKey)),
            _navButton('Portfolio', () => _scrollToSection(_portfolioKey)),
            _navButton('Contact', () => _scrollToSection(_contactKey)),
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
          _drawerTile('Home', Icons.home, () {
            Navigator.pop(context);
            _scrollToSection(_heroKey);
          }),
          _drawerTile('About', Icons.person, () {
            Navigator.pop(context);
            _scrollToSection(_aboutKey);
          }),
          _drawerTile('Services', Icons.settings, () {
            Navigator.pop(context);
            _scrollToSection(_servicesKey);
          }),
          _drawerTile('Portfolio', Icons.work, () {
            Navigator.pop(context);
            _scrollToSection(_portfolioKey);
          }),
          _drawerTile('Contact', Icons.contact_mail, () {
            Navigator.pop(context);
            _scrollToSection(_contactKey);
          }),
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

  Widget _drawerTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accent),
      title: Text(title, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
      onTap: onTap,
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

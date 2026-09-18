import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/widgets/hoverable_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:myportfolio/widgets/responsive.dart';

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    
    int crossAxisCount = 4; // Increased to 4 columns to make cards naturally smaller
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return VisibilityDetector(
      key: ValueKey('services_visibility_${widget.key}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          if (mounted) {
            setState(() => _isVisible = true);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 30 : 120, // Increased horizontal padding to squeeze the grid
          vertical: 80
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const Text(
              'Services',
              style: TextStyle(fontSize: 16, color: AppColors.accent, fontWeight: FontWeight.w600, letterSpacing: 3),
            ).animate(target: _isVisible ? 1 : 0).fadeIn().slideY(begin: 0.2, end: 0),
            const SizedBox(height: 10),
            Text(
              'What I Do for My Clients',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 24 : 32, 
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).textTheme.bodyLarge?.color
              ),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 50),
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.4 : 1.1, // Adjusted for a sleeker rectangular shape
              children: [
                _buildAnimatedServiceCard(
                  Icons.smartphone, 
                  'Cross-Platform Development', 
                  'Creating versatile mobile and web applications that run flawlessly on iOS, Android, and desktop using a unified codebase.',
                  0
                ),
                _buildAnimatedServiceCard(
                  Icons.apps, 
                  'Application Development', 
                  'Developing high-performance frontend interfaces paired with secure, efficient backend systems.',
                  1
                ),
                _buildAnimatedServiceCard(
                  Icons.code, 
                  'Web-App Development', 
                  'Engineering powerful, browser-based software that automates tasks and solves complex business challenges.',
                  2
                ),
                _buildAnimatedServiceCard(
                  Icons.bar_chart, 
                  'Business Intelligence', 
                  'Converting complex datasets into clear, interactive visual stories and dashboards.',
                  3
                ),
                _buildAnimatedServiceCard(
                  Icons.terminal, 
                  'Programming', 
                  'Implementing robust programming logic using modern languages and clean-code principles.',
                  4
                ),
                _buildAnimatedServiceCard(
                  Icons.storage, 
                  'Database Development', 
                  'Engineering secure, scalable, and optimized data architectures and systems.',
                  5
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedServiceCard(IconData icon, String title, String description, int index) {
    return HoverableCard(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 24, color: AppColors.accent),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).textTheme.bodyLarge?.color
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.5, 
                  color: Theme.of(context).textTheme.bodyMedium?.color, 
                  height: 1.3
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (index * 80).ms).scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack);
  }
}

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
    
    int crossAxisCount = 3;
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
          horizontal: isMobile ? 20 : 50, 
          vertical: 80
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            const Text(
              'Services',
              style: TextStyle(fontSize: 18, color: AppColors.accent, fontWeight: FontWeight.w600),
            ).animate(target: _isVisible ? 1 : 0).fadeIn().slideY(begin: 0.2, end: 0),
            Text(
              'What I Do for My Clients',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 28 : 32, 
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).textTheme.bodyLarge?.color
              ),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 50),
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              childAspectRatio: isMobile ? 0.8 : 0.9, // Adjusted for longer text
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
                  'Converting complex datasets into clear, interactive visual stories. I build automated reporting pipelines and intuitive dashboards that streamline business analysis, monitor organizational performance, and simplify executive decision-making.',
                  3
                ),
                _buildAnimatedServiceCard(
                  Icons.terminal, 
                  'Programming', 
                  'Software Engineering & Logic Design. Implementing robust programming logic using modern languages and clean-code principles.',
                  4
                ),
                _buildAnimatedServiceCard(
                  Icons.storage, 
                  'Database Development', 
                  'Engineering secure, scalable, and optimized data architectures. I design and implement relational and non-relational databases that ensure data integrity and high-speed retrieval.',
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: AppColors.accent),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (400 + index * 100).ms).slideY(begin: 0.1, end: 0);
  }
}

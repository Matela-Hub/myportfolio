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
                _ServiceCard(
                  icon: Icons.smartphone, 
                  title: 'Cross-Platform Development', 
                  description: 'Creating versatile mobile and web applications that run flawlessly on iOS, Android, and desktop using a unified codebase.',
                  index: 0,
                  isVisible: _isVisible,
                ),
                _ServiceCard(
                  icon: Icons.apps, 
                  title: 'Application Development', 
                  description: 'Developing high-performance frontend interfaces paired with secure, efficient backend systems.',
                  index: 1,
                  isVisible: _isVisible,
                ),
                _ServiceCard(
                  icon: Icons.code, 
                  title: 'Web-App Development', 
                  description: 'Engineering powerful, browser-based software that automates tasks and solves complex business challenges.',
                  index: 2,
                  isVisible: _isVisible,
                ),
                _ServiceCard(
                  icon: Icons.bar_chart, 
                  title: 'Business Intelligence', 
                  description: 'Converting complex datasets into clear, interactive visual stories and dashboards.',
                  index: 3,
                  isVisible: _isVisible,
                ),
                _ServiceCard(
                  icon: Icons.terminal, 
                  title: 'Programming', 
                  description: 'Implementing robust programming logic using modern languages and clean-code principles.',
                  index: 4,
                  isVisible: _isVisible,
                ),
                _ServiceCard(
                  icon: Icons.storage, 
                  title: 'Database Development', 
                  description: 'Engineering secure, scalable, and optimized data architectures and systems.',
                  index: 5,
                  isVisible: _isVisible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int index;
  final bool isVisible;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.index,
    required this.isVisible,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              _isHovered 
                  ? Theme.of(context).colorScheme.surface 
                  : Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered 
                ? AppColors.accent 
                : AppColors.accent.withValues(alpha: 0.15),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered 
                  ? AppColors.accent.withValues(alpha: 0.3) 
                  : Colors.black.withValues(alpha: 0.15),
              blurRadius: _isHovered ? 20 : 15,
              offset: _isHovered ? const Offset(0, 0) : const Offset(0, 8),
              spreadRadius: _isHovered ? 2 : 0,
            ),
          ],
        ),
        transform: _isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isHovered 
                    ? AppColors.accent.withValues(alpha: 0.2) 
                    : AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon, 
                size: 24, 
                color: AppColors.accent
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
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
                widget.description,
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
    ).animate(target: widget.isVisible ? 1 : 0)
     .fadeIn(delay: (widget.index * 80).ms)
     .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack);
  }
}

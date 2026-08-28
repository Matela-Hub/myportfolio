import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:myportfolio/widgets/responsive.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildContent(context, isMobile: true),
      tablet: _buildContent(context, isMobile: true),
      desktop: _buildContent(context, isMobile: false),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    return VisibilityDetector(
      key: ValueKey('about_visibility_${widget.key}'),
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
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.3),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Me.jpeg',
                  height: isMobile ? 300 : null,
                  width: isMobile ? double.infinity : null,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 200, color: AppColors.accent),
                ),
              ).animate(target: _isVisible ? 1 : 0).fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),
            ),
            if (isMobile) const SizedBox(height: 40) else const SizedBox(width: 50),
            Expanded(
              flex: isMobile ? 0 : 2,
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Who I Am',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideX(begin: 0.1, end: 0),
                  const SizedBox(height: 20),
                  Text(
                    'I am a versatile Full-Stack Developer and Business Information Technology (BIT) specialist. '
                    'Armed with a formal qualification in BIT, I focus on delivering full-spectrum solutions that drive business efficiency.\n\n'
                    'I\'ve built a diverse skill set spanning programming, web development, database management, cloud computing, and information security. '
                    'I\'m particularly interested in digital transformation, business intelligence, and using data to drive better decision-making.\n\n'
                    'I\'m proficient in Object-Oriented Programming, Web Application Development, and Systems Analysis. '
                    'I also have strong foundational knowledge in networking, data communication, and financial information systems.',
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(fontSize: 16, height: 1.5, color: Theme.of(context).textTheme.bodyLarge?.color),
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 40),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildStatCard('4+', 'Projects', 0),
                      _buildStatCard('2+', 'Certifications', 1),
                      _buildStatCard('3+', 'Years Learning', 2),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, int index) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color)),
        ],
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (400 + index * 100).ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack);
  }
}

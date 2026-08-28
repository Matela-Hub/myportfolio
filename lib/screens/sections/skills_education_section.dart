import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsEducationSection extends StatefulWidget {
  const SkillsEducationSection({super.key});

  @override
  State<SkillsEducationSection> createState() => _SkillsEducationSectionState();
}

class _SkillsEducationSectionState extends State<SkillsEducationSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return VisibilityDetector(
      key: ValueKey('skills_visibility_${widget.key}'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Skills',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.accent),
            ).animate(target: _isVisible ? 1 : 0).fadeIn().slideX(begin: -0.2, end: 0),
            const SizedBox(height: 40),
            Center(
              child: Wrap(
                spacing: 25,
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: [
                  _buildSkillCard(context, Icons.code, 'HTML5', 0.9, 0),
                  _buildSkillCard(context, Icons.terminal, 'JavaScript', 0.45, 1),
                  _buildSkillCard(context, Icons.settings, 'Python', 0.5, 2),
                  _buildSkillCard(context, Icons.data_object, 'Dart', 0.7, 3),
                  _buildSkillCard(context, Icons.coffee, 'Java', 0.75, 4),
                  _buildSkillCard(context, Icons.storage, 'SQL', 0.85, 5),
                  _buildSkillCard(context, Icons.cloud, 'AWS', 0.6, 6),
                  _buildSkillCard(context, Icons.web, 'CSS3', 0.85, 7),
                  _buildSkillCard(context, Icons.phone_android, 'Flutter', 0.70, 8),
                ],
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              'Education',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.accent),
            ).animate(target: _isVisible ? 1 : 0).fadeIn().slideX(begin: -0.2, end: 0),
            const SizedBox(height: 40),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: _buildEducationCard(
                    context,
                    'Limkokwing University',
                    'Diploma in Business Information Technology',
                    '2023 - ',
                    'Incomplete',
                    0,
                  ),
                ),
                if (isMobile) const SizedBox(height: 20) else const SizedBox(width: 20),
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: _buildEducationCard(
                    context,
                    'Limkokwing University',
                    'Certification in Business Information Technology',
                    '2021 - 2022',
                    'Completed',
                    1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, IconData icon, String label, double level, int index) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 35, color: AppColors.accent),
          ),
          const SizedBox(height: 15),
          Text(
            label, 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color
            )
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: AppColors.accent.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${(level * 100).toInt()}%',
            style: TextStyle(
              fontSize: 12, 
              color: Theme.of(context).textTheme.bodyMedium?.color
            ),
          ),
        ],
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (index * 100).ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildEducationCard(BuildContext context, String school, String degree, String years, String status, int index) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  status == 'Incomplete' ? Icons.menu_book : Icons.school, 
                  color: AppColors.accent
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  school, 
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold, 
                    color: Theme.of(context).textTheme.bodyLarge?.color
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            degree, 
            style: TextStyle(
              fontSize: 16, 
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.4
            )
          ),
          const SizedBox(height: 10),
          Text(years, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: status == 'Completed' 
                  ? Colors.green.withValues(alpha: 0.8) 
                  : Colors.orange.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status, 
                style: const TextStyle(
                  fontSize: 12, 
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        ],
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (400 + index * 200).ms).slideY(begin: 0.2, end: 0);
  }
}

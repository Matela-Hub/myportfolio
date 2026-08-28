import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/widgets/responsive.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50, 
        vertical: 80
      ),
      child: Column(
        children: [
          const Text(
            'Portfolio',
            style: TextStyle(fontSize: 18, color: AppColors.accent, fontWeight: FontWeight.w600),
          ),
          Text(
            'Check my recent working Projects',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 28 : 32, 
              fontWeight: FontWeight.bold, 
              color: Theme.of(context).textTheme.bodyLarge?.color
            ),
          ),
          const SizedBox(height: 50),
          if (isMobile)
            Column(
              children: [
                _buildProjectCard(context),
                const SizedBox(height: 20),
                _buildProjectCard(context),
                const SizedBox(height: 20),
                _buildProjectCard(context),
              ],
            )
          else
            Row(
              children: [
                Expanded(child: _buildProjectCard(context)),
                const SizedBox(width: 20),
                Expanded(child: _buildProjectCard(context)),
                if (!isTablet) ...[
                  const SizedBox(width: 20),
                  Expanded(child: _buildProjectCard(context)),
                ],
              ],
            ),
          if (isTablet) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildProjectCard(context)),
                const SizedBox(width: 20),
                const Spacer(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.1)),
      ),
      child: const Center(
        child: Text('Project Preview', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onServicesPressed;
  final VoidCallback? onPortfolioPressed;
  final VoidCallback? onContactPressed;

  const FooterSection({
    super.key,
    this.onHomePressed,
    this.onAboutPressed,
    this.onServicesPressed,
    this.onPortfolioPressed,
    this.onContactPressed,
  });

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 60,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Responsive(
            mobile: Column(
              children: _buildFooterItems(context, isMobile: true),
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildFooterItems(context, isMobile: false),
            ),
          ),
          const SizedBox(height: 50),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} Matela Moshate. All rights reserved.',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFooterItems(BuildContext context, {required bool isMobile}) {
    return [
      _buildBrandSection(context, isMobile),
      if (isMobile) const SizedBox(height: 40),
      _buildLinksSection(
        context,
        'Quick Links',
        [
          _LinkItem('Home', onHomePressed),
          _LinkItem('About', onAboutPressed),
          _LinkItem('Portfolio', onPortfolioPressed),
          _LinkItem('Contact', onContactPressed),
        ],
        isMobile,
      ),
      if (isMobile) const SizedBox(height: 40),
      _buildLinksSection(
        context,
        'Services',
        [
          _LinkItem('Web Development', onServicesPressed),
          _LinkItem('App Development', onServicesPressed),
          _LinkItem('Business Intelligence', onServicesPressed),
          _LinkItem('Database Management', onServicesPressed),
        ],
        isMobile,
      ),
      if (isMobile) const SizedBox(height: 40),
      _buildSocialSection(context, isMobile),
    ];
  }

  Widget _buildBrandSection(BuildContext context, bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 250,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const Text(
            'Moshate',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Building digital experiences that combine business logic with modern technology.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinksSection(BuildContext context, String title, List<_LinkItem> items, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: item.onTap,
            child: Text(
              item.label,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 15,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSocialSection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'Stay Connected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSocialIcon(
              Icons.link, 
              onTap: () => _launchURL('https://www.linkedin.com/search/results/all/?keywords=Matela%20Moshate'),
            ),
            const SizedBox(width: 15),
            _buildSocialIcon(
              Icons.code, 
              onTap: () => _launchURL('https://github.com/Matela-Hub'),
            ),
            const SizedBox(width: 15),
            _buildSocialIcon(
              Icons.email, 
              onTap: () => _launchURL('mailto:matelamoshate@gmail.com'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => _launchURL('mailto:matelamoshate@gmail.com'),
          child: Text(
            'matelamoshate@gmail.com',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.accent, size: 20),
      ),
    );
  }
}

class _LinkItem {
  final String label;
  final VoidCallback? onTap;

  _LinkItem(this.label, this.onTap);
}

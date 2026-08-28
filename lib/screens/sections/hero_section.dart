import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onContactPressed;
  
  const HeroSection({super.key, this.onContactPressed});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildContent(context, isMobile: true),
      tablet: _buildContent(context, isMobile: true),
      desktop: _buildContent(context, isMobile: false),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isMobile}) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50, 
        vertical: isMobile ? 50 : 100
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello, My Name Is',
                  style: TextStyle(fontSize: 24),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                const SizedBox(height: 10),
                Text(
                  'Matela Moshate',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: isMobile ? 48 : 64,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms).shimmer(color: Colors.white30),
                const SizedBox(height: 10),
                Text(
                  'Business Information Technologist',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: 20, 
                    color: Theme.of(context).textTheme.bodyMedium?.color
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://docs.google.com/document/d/1eYQ0bhVDGZOtw6U67YE5irBNDIkhqN3m/view?usp=sharing');
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          debugPrint('Could not launch $url');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('DOWNLOAD CV'),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: onContactPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accent),
                        foregroundColor: AppColors.accent,
                      ),
                      child: const Text('CONTACT ME'),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.8, 0.8)),
              ],
            ),
          ),
          if (isMobile) const SizedBox(height: 50),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: isMobile ? 300 : 500,
                  maxWidth: isMobile ? 300 : 500,
                ),
                child: Image.asset(
                  'assets/images/Me1.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 200, color: AppColors.accent),
                ),
              ),
            ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onContactPressed;
  
  const HeroSection({super.key, this.onContactPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isHovered = false;

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
        vertical: isMobile ? 10 : 30 
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
                  style: TextStyle(fontSize: 28),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),
                const SizedBox(height: 10),
                Text(
                  'Matela Moshate',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: isMobile ? 56 : 80,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms).shimmer(color: Colors.white30),
                const SizedBox(height: 10),
                Text(
                  'Business Information Technologist',
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  style: TextStyle(
                    fontSize: 26, 
                    color: Theme.of(context).textTheme.bodyMedium?.color
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
                const SizedBox(height: 40),
                Wrap(
                  alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    MouseRegion(
                      onEnter: (_) => setState(() => _isHovered = true),
                      onExit: (_) => setState(() => _isHovered = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isHovered ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.6),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ] : [],
                        ),
                        child: ElevatedButton(
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
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                            elevation: _isHovered ? 0 : 2, // Switch to shadow box on hover
                          ),
                          child: const Text('DOWNLOAD CV'),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: widget.onContactPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accent, width: 2),
                        foregroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                      child: const Text('CONTACT ME'),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.8, 0.8)),
              ],
            ),
          ),
          if (isMobile) const SizedBox(height: 30),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Align(
              alignment: isMobile ? Alignment.topCenter : Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: isMobile ? 600 : 1100, 
                  maxWidth: isMobile ? 600 : 1100,
                ),
                child: Image.asset(
                  'assets/images/Me1.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 400, color: AppColors.accent),
                ),
              ),
            ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
          ),
        ],
      ),
    );
  }
}

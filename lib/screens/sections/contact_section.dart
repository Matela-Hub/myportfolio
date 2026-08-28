import 'package:flutter/material.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:myportfolio/widgets/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isVisible = false;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    }
  }

  void _sendEmail() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String phone = _phoneController.text;
    final String message = _messageController.text;

    final String subject = Uri.encodeComponent('Portfolio Inquiry from $name');
    final String body = Uri.encodeComponent(
      'Name: $name\n'
      'Email: $email\n'
      'Phone: $phone\n\n'
      'Message:\n$message'
    );

    _launchURL('mailto:matelamoshate@gmail.com?subject=$subject&body=$body');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return VisibilityDetector(
      key: ValueKey('contact_visibility_${widget.key}'),
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
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
        child: Column(
          children: [
            const Text(
              'Contacts',
              style: TextStyle(fontSize: 18, color: AppColors.accent, fontWeight: FontWeight.w600),
            ).animate(target: _isVisible ? 1 : 0).fadeIn().slideY(begin: 0.2, end: 0),
            Text(
              'I Want to Hear from You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 28 : 32, 
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).textTheme.bodyLarge?.color
              ),
            ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 50),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    children: [
                      _buildContactMethod(
                        Icons.phone, 
                        '+266 59633745',
                        0,
                        onTap: () => _launchURL('tel:+26659933741'),
                      ),
                      _buildContactMethod(
                        Icons.message, 
                        'WhatsApp', 
                        1,
                        onTap: () => _launchURL('https://wa.me/26663490639'),
                      ),
                      _buildContactMethod(
                        Icons.email, 
                        'Sent a Message', 
                        2,
                        onTap: () => _launchURL('mailto:matelamoshate@gmail.com'),
                      ),
                      _buildContactMethod(
                        Icons.link, 
                        'View LinkedIn Profile', 
                        3,
                        onTap: () => _launchURL('https://www.linkedin.com/search/results/all/?keywords=Matela%20Moshate'),
                      ),
                      _buildContactMethod(
                        Icons.code, 
                        'View GitHub Repositories', 
                        4,
                        onTap: () => _launchURL('https://github.com/Matela-Hub'),
                      ),
                    ],
                  ),
                ),
                if (isMobile) const SizedBox(height: 50) else const SizedBox(width: 50),
                Expanded(
                  flex: isMobile ? 0 : 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildTextField('Name*', controller: _nameController)),
                          const SizedBox(width: 20),
                          Expanded(child: _buildTextField('Email*', controller: _emailController)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTextField('Phone Number*', controller: _phoneController),
                      const SizedBox(height: 20),
                      _buildTextField('Your Message*', maxLines: 5, controller: _messageController),
                      const SizedBox(height: 30),
                      Align(
                        alignment: isMobile ? Alignment.center : Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: _sendEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            elevation: 5,
                          ),
                          child: const Text('SUBMIT', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: 400.ms).slideX(begin: 0.1, end: 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethod(IconData icon, String label, int index, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.accent, size: 24),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.05)),
                ),
                child: Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
              ),
            ),
          ],
        ),
      ),
    ).animate(target: _isVisible ? 1 : 0).fadeIn(delay: (400 + index * 100).ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildTextField(String hint, {int maxLines = 1, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.accent.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.accent.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}

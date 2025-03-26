import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Responsive.isMobile(context) ? 
          CustomBackButton() : null,
        scrolledUnderElevation: 0,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              color: Colors.black,
              child: const Column(
                children: [
                  Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'PRIVACY POLICY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last Updated: March 2025',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.black,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'YOUR PRIVACY MATTERS',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'At Tech Haven, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and safeguard your personal information.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildPrivacySection(
                    icon: Icons.person,
                    title: 'Information We Collect',
                    content: 'We collect information you provide when you register, make a purchase, or contact us. This may include your name, email address, shipping address, and payment details.',
                  ),
                  buildPrivacySection(
                    icon: Icons.analytics,
                    title: 'How We Use Your Information',
                    content: 'To process and fulfill your orders. To communicate with you about your orders and our services. To improve our platform and customer service.',
                  ),
                  buildPrivacySection(
                    icon: Icons.share,
                    title: 'Information Sharing',
                    content: 'We do not sell or rent your personal information to third parties. We may share your information with trusted partners to fulfill orders and improve our services.',
                  ),
                  buildPrivacySection(
                    icon: Icons.security,
                    title: 'Data Security',
                    content: 'We implement security measures to protect your personal information from unauthorized access, alteration, or disclosure.',
                  ),
                  buildPrivacySection(
                    icon: Icons.check_circle,
                    title: 'Your Choices',
                    content: 'You can update your account information and preferences at any time. You can opt-out of receiving marketing communications from us.',
                  ),
                  buildPrivacySection(
                    icon: Icons.cookie,
                    title: 'Cookies and Tracking',
                    content: 'We use cookies to enhance your shopping experience. You can control cookies through your browser settings.',
                  ),
                  buildPrivacySection(
                    icon: Icons.family_restroom,
                    title: 'Children\'s Privacy',
                    content: 'Our services are not intended for children under 13. We do not knowingly collect personal information from children under 13.',
                  ),
                  buildPrivacySection(
                    icon: Icons.update,
                    title: 'Changes to This Policy',
                    content: 'We may update this Privacy Policy from time to time. Changes will be effective upon posting on our website.',
                  ),
                  buildPrivacySection(
                    icon: Icons.contact_mail,
                    title: 'Contact Us',
                    content: 'If you have any questions about this Privacy Policy, please contact us at rabeehm802@gmail.com.',
                    isLast: true,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black, width: 1.5),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'DOWNLOAD PDF',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: const Column(
                children: [
                  Text(
                    '© 2025 Tech Haven',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Privacy First. Always.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPrivacySection({
    required IconData icon,
    required String title,
    required String content,
    bool isLast = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: !isLast ? Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
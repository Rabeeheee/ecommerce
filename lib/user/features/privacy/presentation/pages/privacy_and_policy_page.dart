import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/privacy/presentation/widgets/privacy_header.dart';
import 'package:tech_haven/user/features/privacy/presentation/widgets/privacy_section.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.whiteColor,
        leading: Responsive.isMobile(context)? CustomBackButton() : null,
        scrolledUnderElevation: 0,
        title: const Text('Privacy Policy'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrivacyHeader(
                header: 'Privacy Policy',
                fontSize: 24,
              ),
              SizedBox(height: 10),
              Text(
                'At Tech Haven, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and safeguard your personal information.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              PrivacySection(
                title: 'Information We Collect',
                content:
                    'We collect information you provide when you register, make a purchase, or contact us. This may include your name, email address, shipping address, and payment details.',
              ),
              PrivacySection(
                title: 'How We Use Your Information',
                content:
                    'To process and fulfill your orders. To communicate with you about your orders and our services. To improve our platform and customer service.',
              ),
              PrivacySection(
                title: 'Information Sharing',
                content:
                    'We do not sell or rent your personal information to third parties. We may share your information with trusted partners to fulfill orders and improve our services.',
              ),
              PrivacySection(
                title: 'Data Security',
                content:
                    'We implement security measures to protect your personal information from unauthorized access, alteration, or disclosure.',
              ),
              PrivacySection(
                title: 'Your Choices',
                content:
                    'You can update your account information and preferences at any time. You can opt-out of receiving marketing communications from us.',
              ),
              PrivacySection(
                title: 'Cookies and Tracking',
                content:
                    'We use cookies to enhance your shopping experience. You can control cookies through your browser settings.',
              ),
              PrivacySection(
                title: 'Children\'s Privacy',
                content:
                    'Our services are not intended for children under 13. We do not knowingly collect personal information from children under 13.',
              ),
              PrivacySection(
                title: 'Changes to This Policy',
                content:
                    'We may update this Privacy Policy from time to time. Changes will be effective upon posting on our website.',
              ),
              PrivacySection(
                title: 'Contact Us',
                content:
                    'If you have any questions about this Privacy Policy, please contact us at rayidrasal@gmail.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

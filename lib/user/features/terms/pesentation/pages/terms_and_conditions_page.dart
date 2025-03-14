import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/terms/pesentation/widgets/terms_header.dart';
import 'package:tech_haven/user/features/terms/pesentation/widgets/terms_section.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.whiteColor,
        leading:Responsive.isMobile(context)?  CustomBackButton() : null,
        scrolledUnderElevation: 0,
        title: const Text('Terms and Conditions'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TermsHeader(
                header: 'Terms and Conditions',
                fontSize: 24,
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to Tech Haven. By accessing and using our platform, you agree to comply with and be bound by the following terms and conditions:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              TermsSection(
                title: 'Introduction',
                content:
                    'These terms govern your use of our website and services. By using our site, you accept these terms in full.',
              ),
              TermsSection(
                title: 'User Responsibilities',
                content:
                    'You must be at least 18 years old to use our services. You are responsible for maintaining the confidentiality of your account and password.',
              ),
              TermsSection(
                title: 'Product Purchases',
                content:
                    'All sales are subject to product availability. We reserve the right to refuse or cancel any order for any reason.',
              ),
              TermsSection(
                title: 'Vendor Registration',
                content:
                    'Vendors must provide accurate and complete information during registration. Vendors are responsible for the products they list and sell on our platform.',
              ),
              TermsSection(
                title: 'Payment and Fees',
                content:
                    'Payments for purchases and sales must be made through our secure payment gateway. We may charge fees for certain services, which will be clearly disclosed.',
              ),
              TermsSection(
                title: 'Privacy Policy',
                content:
                    'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information.',
              ),
              TermsSection(
                title: 'Limitation of Liability',
                content:
                    'Tech Haven is not liable for any damages arising from the use of our platform.',
              ),
              TermsSection(
                title: 'Changes to Terms',
                content:
                    'We reserve the right to update these terms at any time. Changes will be effective upon posting on our website.',
              ),
              TermsSection(
                title: 'Contact Us',
                content:
                    'If you have any questions about these terms, please contact us at rayidrasal@gmail.com',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


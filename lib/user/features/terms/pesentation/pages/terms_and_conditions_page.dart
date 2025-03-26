import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';


class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
          'Terms and Conditions',
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
                    Icons.gavel,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'TERMS & CONDITIONS',
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
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Welcome to Tech Haven. By accessing and using our platform, you agree to comply with and be bound by the following terms and conditions:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildTermsSection(
                    index: '01',
                    title: 'Introduction',
                    content: 'These terms govern your use of our website and services. By using our site, you accept these terms in full.',
                  ),
                  buildTermsSection(
                    index: '02',
                    title: 'User Responsibilities',
                    content: 'You must be at least 18 years old to use our services. You are responsible for maintaining the confidentiality of your account and password.',
                  ),
                  buildTermsSection(
                    index: '03',
                    title: 'Product Purchases',
                    content: 'All sales are subject to product availability. We reserve the right to refuse or cancel any order for any reason.',
                  ),
                  buildTermsSection(
                    index: '04',
                    title: 'Vendor Registration',
                    content: 'Vendors must provide accurate and complete information during registration. Vendors are responsible for the products they list and sell on our platform.',
                  ),
                  buildTermsSection(
                    index: '05',
                    title: 'Payment and Fees',
                    content: 'Payments for purchases and sales must be made through our secure payment gateway. We may charge fees for certain services, which will be clearly disclosed.',
                  ),
                  buildTermsSection(
                    index: '06',
                    title: 'Privacy Policy',
                    content: 'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information.',
                  ),
                  buildTermsSection(
                    index: '07',
                    title: 'Limitation of Liability',
                    content: 'Tech Haven is not liable for any damages arising from the use of our platform.',
                  ),
                  buildTermsSection(
                    index: '08',
                    title: 'Changes to Terms',
                    content: 'We reserve the right to update these terms at any time. Changes will be effective upon posting on our website.',
                  ),
                  buildTermsSection(
                    index: '09',
                    title: 'Contact Us',
                    content: 'If you have any questions about these terms, please contact us at rayidrasal@gmail.com',
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'I ACCEPT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
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
                    'All Rights Reserved',
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

  Widget buildTermsSection({
    required String index,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    index,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 56, top: 12, bottom: 24),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
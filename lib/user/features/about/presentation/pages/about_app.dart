import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';


class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Responsive.isMobile(context) ? const CustomBackButton() : null,
        scrolledUnderElevation: 0,
        title: const Text(
          'About Tech Haven',
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
              height: 200,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.devices,
                      size: 60,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'TECH HAVEN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 50,
                      height: 3,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSectionHeader('Welcome to Tech Haven'),
                  const SizedBox(height: 16),
                  buildParagraph(
                    'Your one-stop destination for the latest and greatest in electronics. At Tech Haven, we strive to provide our customers with a seamless shopping experience, offering a wide range of high-quality products from top brands at competitive prices.',
                  ),
                  const SizedBox(height: 36),
                  buildSectionHeader('Our Mission'),
                  const SizedBox(height: 16),
                  buildParagraph(
                    'Our mission is to revolutionize the way people shop for electronics by providing an easy, reliable, and enjoyable online shopping experience. We are committed to delivering exceptional value, outstanding customer service, and innovative solutions to meet your tech needs.',
                  ),
                  const SizedBox(height: 36),
                  buildSectionHeader('Why Choose Us?'),
                  const SizedBox(height: 16),
                  buildFeatureItem(
                    icon: Icons.category,
                    title: 'Wide Selection',
                    description: 'Discover a vast array of electronics, from smartphones and laptops to home appliances and gadgets.',
                  ),
                  buildFeatureItem(
                    icon: Icons.local_offer,
                    title: 'Competitive Prices',
                    description: 'Enjoy unbeatable deals and discounts on top-quality products.',
                  ),
                  buildFeatureItem(
                    icon: Icons.security,
                    title: 'Secure Shopping',
                    description: 'Shop with confidence knowing that your personal information is protected.',
                  ),
                  buildFeatureItem(
                    icon: Icons.store,
                    title: 'Vendor Opportunities',
                    description: 'Register as a vendor and start selling your own products, earning money while reaching a wide audience.',
                  ),
                  const SizedBox(height: 36),
                  buildSectionHeader('Join Us'),
                  const SizedBox(height: 16),
                  buildParagraph(
                    'Whether you\'re a tech enthusiast or a budding entrepreneur, Tech Haven is the perfect place for you. Join our community today and experience the future of electronics shopping.',
                  ),
                  const SizedBox(height: 32),
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
                        'SIGN UP NOW',
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
                    'The Future of Tech Shopping',
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

  Widget buildSectionHeader(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.6,
      ),
    );
  }

  Widget buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
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
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
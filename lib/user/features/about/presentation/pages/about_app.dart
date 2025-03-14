import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/responsive/responsive.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/user/features/about/presentation/widgets/about_page_header.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.whiteColor,
        leading: Responsive.isMobile(context) ? const CustomBackButton() : null,
        scrolledUnderElevation: 0,
        title: const Text('About Tech Haven'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutPageHeader(
                header: 'Welcome to Tech Haven',
                fontSize: 24,
              ),
              SizedBox(height: 10),
              Text(
                'Your one-stop destination for the latest and greatest in electronics. At Tech Haven, we strive to provide our customers with a seamless shopping experience, offering a wide range of high-quality products from top brands at competitive prices.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              AboutPageHeader(
                header: 'Our Mission',
                fontSize: 22,
              ),
              SizedBox(height: 10),
              Text(
                'Our mission is to revolutionize the way people shop for electronics by providing an easy, reliable, and enjoyable online shopping experience. We are committed to delivering exceptional value, outstanding customer service, and innovative solutions to meet your tech needs.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              AboutPageHeader(
                header: 'Why Choose Us?',
                fontSize: 22,
              ),
              SizedBox(height: 10),
              Text(
                '• Wide Selection: Discover a vast array of electronics, from smartphones and laptops to home appliances and gadgets.\n'
                '• Competitive Prices: Enjoy unbeatable deals and discounts on top-quality products.\n'
                '• Secure Shopping: Shop with confidence knowing that your personal information is protected.\n'
                '• Vendor Opportunities: Register as a vendor and start selling your own products, earning money while reaching a wide audience.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              AboutPageHeader(
                header: 'Join Us',
                fontSize: 22,
              ),
              SizedBox(height: 10),
              Text(
                'Whether you\'re a tech enthusiast or a budding entrepreneur, Tech Haven is the perfect place for you. Join our community today and experience the future of electronics shopping.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

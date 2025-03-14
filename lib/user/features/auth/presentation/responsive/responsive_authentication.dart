import 'package:flutter/material.dart';
import 'package:tech_haven/core/responsive/responsive.dart';

class ResponsiveAuthentication extends StatelessWidget {
  const ResponsiveAuthentication(
      {super.key,
      this.desktopLayout,
      required this.mobileLayout,
      this.tabletLayout});

  final Widget mobileLayout;
  final Widget? tabletLayout;
  final Widget? desktopLayout;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (Responsive.isMobile(context)) mobileLayout,
          if (Responsive.isTablet(context) && tabletLayout != null)
            tabletLayout!,
          if (Responsive.isDesktop(context) && desktopLayout != null)
            desktopLayout!
          else
            mobileLayout
        ],
      ),
    );
  }
}

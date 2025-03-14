import 'package:flutter/material.dart';

class SpecificationListView extends StatelessWidget {
  final Map<String, String> specifications;

  const SpecificationListView({
    super.key,
    required this.specifications,
    this.canScroll = false,
  });
  final bool canScroll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        physics: canScroll ? null : const NeverScrollableScrollPhysics(),
        itemCount: specifications.length,
        itemBuilder: (context, index) {
          String specType = specifications.keys.elementAt(index);
          String specValue = specifications.values.elementAt(index);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: index % 2 != 0
                  ? Colors.grey.withOpacity(0.5) // Replace with your color
                  : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    specType,
                    style: const TextStyle(
                      color: Colors.black, // Adjust as needed
                      fontSize: 12,
                    ),
                  ),
                ),
                const Flexible(
                  child: SizedBox(
                    width: 8,
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ), // Adjust spacing between specType and specValue
                Flexible(
                  child: Text(
                    specValue,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black, // Adjust as needed
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

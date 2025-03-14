import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/entities/category.dart';

class DropDownWidgets extends StatefulWidget {
  const DropDownWidgets({
    super.key,
    required this.allCategories,
    required this.categoryIndexes,
    // this.mainCategoryValue,
    // this.subCategoryValue,
    // this.variantCategoryValue,
  });

  final List<Category> allCategories;

  final List<int?> categoryIndexes;

  // final String? mainCategoryValue;
  // final String? subCategoryValue;
  // final String? variantCategoryValue;

  // int? mainCategoryIndex;
  // int? subCategoryIndex;
  // int? variantCategoryIndex;

  @override
  State<DropDownWidgets> createState() => _DropDownWidgetsState();
}
TextEditingController mainSearchEditingController = TextEditingController();
TextEditingController subSearchEditingController = TextEditingController();
TextEditingController variantSearchEditingController = TextEditingController();
// Getter methods to access index values
// int? get mainCategoryIndex => widget.categoryIndexes[0];
// int? get subCategoryIndex => widget.categoryIndexes[1];
// int? get variantCategoryIndex => widget.categoryIndexes[2];

class _DropDownWidgetsState extends State<DropDownWidgets> {
  String? mainCategoryValue;
  String? subCategoryValue;
  String? variantCategoryValue;
  @override
  Widget build(BuildContext context) {
    if (widget.categoryIndexes[0] != null &&
        widget.categoryIndexes[1] != null &&
        widget.categoryIndexes[2] != null) {
      mainCategoryValue =
          widget.allCategories[widget.categoryIndexes[0]!].categoryName;
      subCategoryValue = widget.allCategories[widget.categoryIndexes[0]!]
          .subCategories[widget.categoryIndexes[1]!].categoryName;
      variantCategoryValue = widget
          .allCategories[widget.categoryIndexes[0]!]
          .subCategories[widget.categoryIndexes[1]!]
          .subCategories[widget.categoryIndexes[2]!]
          .categoryName;
      // widget.categoryIndexes[0] = widget.allCategories.indexWhere((element) =>
      //     element.categoryName ==
      //     widget.allCategories[widget.categoryIndexes[0]!].categoryName);
      // widget.categoryIndexes[1] = widget
      //     .allCategories[widget.categoryIndexes[0]!].subCategories
      //     .indexWhere((element) =>
      //         element.categoryName ==
      //         widget.allCategories[widget.categoryIndexes[0]!]
      //             .subCategories[widget.categoryIndexes[1]!].categoryName);
      // widget.categoryIndexes[2] = widget
      //     .allCategories[widget.categoryIndexes[0]!]
      //     .subCategories[widget.categoryIndexes[1]!]
      //     .subCategories
      //     .indexWhere((element) =>
      //         element.categoryName ==
      //         widget.allCategories[widget.categoryIndexes[0]!].subCategories[widget.categoryIndexes[1]!].subCategories[widget.categoryIndexes[2]!].categoryName);
    }
    return Column(
      children: [
        CustomDropDown<String>(
          searchEditingController: mainSearchEditingController,
          hintText: 'Select Main Category',
          currentItem: mainCategoryValue,
          items: widget.allCategories.map((e) => e.categoryName).toList(),
          onChanged: (value) {
            final categoryIndex = widget.allCategories
                .indexWhere((element) => element.categoryName == value);
            if (subCategoryValue == null) {
              setState(() {
                mainCategoryValue = value;
                widget.categoryIndexes[0] = categoryIndex;
              });
            } else {
              setState(() {
                mainCategoryValue = value;

                widget.categoryIndexes[0] = categoryIndex;
                subCategoryValue = null;
                widget.categoryIndexes[1] = null;
                widget.categoryIndexes[2] = null;
                variantCategoryValue = null;
              });
            }
          },
        ),
        Constants.kHeight,
        // droopdown for product main category
        CustomDropDown<String>(
          searchEditingController: subSearchEditingController,
          hintText: 'Select Sub Category',
          currentItem: subCategoryValue,
          items: widget.categoryIndexes[0] != null
              ? widget.allCategories[widget.categoryIndexes[0]!].subCategories
                  .map((e) => e.categoryName)
                  .toList()
              : [],
          onChanged: (value) {
            final categoryIndex = widget
                .allCategories[widget.categoryIndexes[0]!].subCategories
                .indexWhere((element) => element.categoryName == value);
            setState(() {
              subCategoryValue = value;
              widget.categoryIndexes[1] = categoryIndex;
            });
          },
        ),
        CustomDropDown<String>(
          searchEditingController: variantSearchEditingController,
          hintText: 'Select Variant Cateogry',
          currentItem: variantCategoryValue,
          items: widget.categoryIndexes[1] != null
              ? widget.allCategories[widget.categoryIndexes[0]!]
                  .subCategories[widget.categoryIndexes[1]!].subCategories
                  .map((e) => e.categoryName)
                  .toList()
              : [],
          onChanged: (value) {
            final categoryIndex = widget
                .allCategories[widget.categoryIndexes[0]!]
                .subCategories[widget.categoryIndexes[1]!]
                .subCategories
                .indexWhere((element) => element.categoryName == value);
            setState(() {
              variantCategoryValue = value;
              widget.categoryIndexes[2] = categoryIndex;
            });
          },
        ),
      ],
    );
  }
}

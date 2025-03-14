import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_drop_down.dart';
import 'package:tech_haven/core/entities/category.dart';

class BrandDropDown extends StatefulWidget {
  const BrandDropDown({
    super.key,
    required this.allBrandsModel,
    required this.selectedBrandIndex,
  });

  final List<Category> allBrandsModel;
  final List<int?> selectedBrandIndex;

  @override
  State<BrandDropDown> createState() => _BrandDropDownState();
}

String? selectedValue;
TextEditingController searchEditingController = TextEditingController();

class _BrandDropDownState extends State<BrandDropDown> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedBrandIndex[0] != null) {
      selectedValue =
          widget.allBrandsModel[widget.selectedBrandIndex[0]!].categoryName;
    }
    return CustomDropDown(
      searchEditingController: searchEditingController,
      items: widget.allBrandsModel.map((e) => e.categoryName).toList(),
      currentItem: selectedValue,
      hintText: 'Select Brand',
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.selectedBrandIndex[0] = widget.allBrandsModel
            .indexWhere((element) => element.categoryName == value);
      },
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.currentItem,
      this.onChanged,
      this.hintText = 'Select Item',
      required this.searchEditingController});
  final TextEditingController searchEditingController;
  final List<T> items;
  final T? currentItem;
  final void Function(T?)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: Text(
          hintText,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item
                        .toString()
                        .split('.')
                        .last, // Display only enum value name
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: currentItem,
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          overlayColor: WidgetStatePropertyAll(
            Color(0xFF2F353E),
          ),
          height: 45,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        // dropdownSearchData: DropdownSearchData(
        //   searchController: searchEditingController,
        //   searchInnerWidgetHeight: 50,
        //   searchInnerWidget: Container(
        //     height: 50,
        //     padding: const EdgeInsets.only(
        //       top: 8,
        //       bottom: 4,
        //       right: 8,
        //       left: 8,
        //     ),
        //     child: TextFormField(
        //       expands: true,
        //       maxLines: null,
        //       decoration: InputDecoration(
        //         isDense: true,
        //         contentPadding: const EdgeInsets.symmetric(
        //           horizontal: 10,
        //           vertical: 8,
        //         ),
        //         hintText: 'Search for an item...',
        //         hintStyle: const TextStyle(fontSize: 12),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8),
        //         ),
        //       ),
        //     ),
        //   ),
        //   searchMatchFn: (item, searchValue) {

        //     return item.value.toString().contains(searchValue);
        //   },
        // ),
      ),
    );
  }
}

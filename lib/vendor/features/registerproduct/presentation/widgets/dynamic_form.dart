
import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({
    super.key,
    required this.onFormChanged,
    required this.productSpecifications,
  });
  final Function(Map<String, String>) onFormChanged;
  final Map<String, String> productSpecifications;
  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<MapEntry<TextEditingController, TextEditingController>> fields = [
    MapEntry(TextEditingController(), TextEditingController()),
  ];

  @override
  void initState() {
    if (widget.productSpecifications.isNotEmpty) {
      fields = widget.productSpecifications.entries.map((entry) {
        return MapEntry(
          TextEditingController(text: entry.key),
          TextEditingController(text: entry.value),
        );
      }).toList();
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var entry in fields) {
      entry.key.dispose();
      entry.value.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      fields.add(MapEntry(TextEditingController(), TextEditingController()));
    });
    _updateFormData();
  }

  void _removeField(int index) {
    setState(() {
      fields.removeAt(index);
    });
    _updateFormData();
  }

  void _updateFormData() {
    Map<String, String> result = {};
    for (var entry in fields) {
      if (entry.key.text.isNotEmpty && entry.value.text.isNotEmpty) {
        result[entry.key.text] = entry.value.text;
      }
    }
    widget.onFormChanged(result);
  }

  //whent the fields length - 1 == index then we will show the plusbuttonnnnnn
  //if the

  @override
  Widget build(BuildContext context) {
    // print(widget.productSpecifications);
    // print(widget.productSpecifications.isNotEmpty);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: fields.length,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  labelText: 'Name',
                  hintText: 'Name',
                  durationMilliseconds: 150,
                  textEditingController: fields[index].key,
                  onChanged: (value) => _updateFormData(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  labelText: 'Spec.',
                  hintText: 'Spec.',
                  textEditingController: fields[index].value,
                  durationMilliseconds: 150,
                  onChanged: (value) => _updateFormData(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(fields.length - 1 == index ? Icons.add : Icons.remove),
              onPressed: () {
                if (fields.length - 1 == index) {
                  // if (fields.length > 1) {
                  _addField();
                  // }
                } else {
                  _removeField(index);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
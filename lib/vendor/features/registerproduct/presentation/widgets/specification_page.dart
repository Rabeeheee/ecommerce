import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';

class SpecificationPage extends StatefulWidget {
  final Map<int, Map<String, String>> specificationTextFormFields;
  const SpecificationPage(
      {super.key, required this.specificationTextFormFields});

  @override
  State<SpecificationPage> createState() => _SpecificationPageState();
}

class _SpecificationPageState extends State<SpecificationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.specificationTextFormFields.length + 1,
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  labelText: 'Name',
                  hintText: 'Name',
                  durationMilliseconds: 150,
                  textEditingController: null,
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  labelText: 'Spec.',
                  hintText: 'Spec.',
                  textEditingController: null,
                  durationMilliseconds: 150,
                ),
              ),
            ),
            index < widget.specificationTextFormFields.length - 1
                ? IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        widget.specificationTextFormFields.remove(index);
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // final Map<String, String> newEntry =
                      final Map<String, String> myMap = {};

                      // myMap[index.toString()] = '';

                      setState(() {
                        widget.specificationTextFormFields[index] = myMap;
                      });
                    },
                  ),
          ],
        );
      },
    );
  }
}

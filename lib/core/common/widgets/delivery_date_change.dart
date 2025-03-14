import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/utils/sum.dart';

import '../../entities/order.dart'  as model;

class DeliveryDateChange extends StatefulWidget {
  const DeliveryDateChange({
    super.key,
    required this.order,
  });

  final model.Order order;

  @override
  State<DeliveryDateChange> createState() => _DeliveryDateChangeState();
}

class _DeliveryDateChangeState extends State<DeliveryDateChange> {
  String? formattedDate;
  Future<void> pickDate(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime startDate,
      required DateTime endDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: startDate,
      lastDate: endDate,
    );
    if (picked != null) {
      //change the date now from the database
      setState(() {
        formattedDate = formatDateTime(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Date of Delivery',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        const SvgIcon(
          icon: CustomIcons.chevronDownSvg,
          radius: 10,
        ),
        TextButton.icon(
          onPressed: () {
            pickDate(
                context: context,
                initialDate: widget.order.deliveryDate,
                startDate: widget.order.orderDate,
                endDate: DateTime(2500));
          },
          icon: const Icon(
            Icons.pending_actions,
            size: 16,
          ),
          label: Text(
            formattedDate ??
                formatDateTime(
                  widget.order.deliveryDate,
                ),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

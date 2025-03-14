import 'package:flutter/material.dart';

class CountryCodeContainer extends StatelessWidget {
  const CountryCodeContainer({
    super.key,
    required this.onTap,
    required this.countryCode,  this.enabled = true,
  });

  final void Function()? onTap;
  final String countryCode;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      height: 50,
      width: 90,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              bottom: 2,
              child: Text(
                countryCode,
                style: const TextStyle(
                  fontSize: 16,
                ),
              )),
          TextFormField(
            onTap: onTap,
            enabled: enabled,
            enableInteractiveSelection: false,
            canRequestFocus: false,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              prefixIconConstraints: BoxConstraints(maxHeight: 0, maxWidth: 0),
              suffixIconConstraints: BoxConstraints(
                maxHeight: 0,
              ),
              contentPadding: EdgeInsets.only(top: 8),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: 2,
                ),
                child: Icon(
                  Icons.add,
                  size: 15,
                ),
              ),
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              ),
              label: Text(
                'Country Code',
                softWrap: false,
                style: TextStyle(
                  fontSize: 15,
                  overflow: TextOverflow.visible,
                ),
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }
}

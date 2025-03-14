import 'package:flutter/material.dart';

class SaveButton extends StatefulWidget {
  final void Function()? onPressed;
  final bool isLoading;

  const SaveButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          Colors.green,
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      child: widget.isLoading
          ? const SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
    );
  }
}

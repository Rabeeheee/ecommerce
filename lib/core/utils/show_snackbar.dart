import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String content,
  required ContentType contentType,
}) {
  final snackbar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: content,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
  // ScaffoldMessenger.of(context)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(
  //     SnackBar(
  //       content: Text(content),
  //     ),
  //   );
}

Future<bool?> showConfirmationDialog(BuildContext context, String title,
    String content, Function onConfirmed) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              onConfirmed();
              Navigator.of(context).pop(true); // Return true when confirmed
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false when cancelled
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

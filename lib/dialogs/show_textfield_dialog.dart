import 'package:flutter/material.dart';

enum TextFieldDialogButtonType { cancel, confirm }

typedef TextFieldOptionbuilder<T> = Map<TextFieldDialogButtonType, T?>
    Function();

late final controller = TextEditingController();
Future<String?> showTextFieldDialog({
  required BuildContext context,
  required String title,
  required String? hintText,
  required TextFieldOptionbuilder optionbuilder,
}) {
  controller.clear();
  final options = optionbuilder();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
      actions: options.entries.map((e) {
        return TextButton(
            onPressed: () {
              switch (e.key) {
                case TextFieldDialogButtonType.cancel:
                  Navigator.of(context).pop();
                  break;
                case TextFieldDialogButtonType.confirm:
                  Navigator.of(context).pop(controller.text);
                  break; 
              }
            },
            child: e.value);
      }).toList(),
    ),
  );
}

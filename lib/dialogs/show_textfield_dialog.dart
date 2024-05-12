import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum TextFieldDialogButtonType { cancel, confirm }

typedef TextFieldOptionbuilder<T> = Map<TextFieldDialogButtonType, T?>
    Function();

final controller = useTextEditingController(text: '');
Future<String?> showTextFieldDialog({
  required BuildContext context,
  required String title,
  required String? hintText,
  required TextFieldOptionbuilder optionbuilder,
}) {
  controller.clear();
  final options = optionbuilder();
  return showDialog<String?>(
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

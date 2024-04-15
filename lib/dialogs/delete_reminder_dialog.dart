import 'package:flutter/material.dart';
import 'package:mobx_flutter/dialogs/generic_dialog.dart';

Future<bool> showDeleteReminderDialog({required BuildContext context}) {
  return showGenericDialog(
      context: context,
      content: 'Are you sure to want to delete the Reminder',
      title: 'Delete Reminder',
      optionBuilder: () => {
            'Cancel': false,
            'Delete': true,
          }).then((value) => value ?? false);
}

import 'package:flutter/material.dart';
import 'package:mobx_flutter/dialogs/generic_dialog.dart';

Future<bool> showlogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    content: 'Are you sure you want to log out?',
    title: 'Log out',
    optionBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}

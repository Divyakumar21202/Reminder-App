import 'package:flutter/material.dart';
import 'package:mobx_flutter/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    content: 'Are you sure you want to delete your account',
    title: 'Delete Account',
    optionBuilder: () => {
      'Cancel': false,
      'Delete Account': true,
    },
  ).then(
    (value) => value ?? false,
  );
}

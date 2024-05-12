import 'package:flutter/material.dart';
import 'package:mobx_flutter/auth/auth_error.dart';
import 'package:mobx_flutter/dialogs/generic_dialog.dart';
import 'package:mobx_flutter/state/app_state.dart';
import 'package:provider/provider.dart';

Future<void> showAuthErrorDialog({
  required BuildContext context,
  required AuthError authError,
}) {
  context.read<AppState>().authError = null;
  return showGenericDialog<bool>(
    context: context,
    content: authError.dialogText,
    title: authError.dialogTitle,
    optionBuilder: () => {
      'Ok': true,
    },
  );
}

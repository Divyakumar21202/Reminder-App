import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_flutter/dialogs/delete_reminder_dialog.dart';
import 'package:mobx_flutter/dialogs/show_textfield_dialog.dart';
import 'package:mobx_flutter/state/app_state.dart';
import 'package:mobx_flutter/views/main_popup_menu_button.dart';
import 'package:provider/provider.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        actions: [
          IconButton(
            onPressed: () async {
              final textdialog = await showTextFieldDialog(
                context: context,
                title: 'What to remind ?',
                hintText: 'Enter your reminder',
                optionbuilder: () => {
                  TextFieldDialogButtonType.cancel: 'Cancel',
                  TextFieldDialogButtonType.confirm: 'Save',
                },
              );
              if (textdialog != null) {
                context.read<AppState>().addReminder(textdialog);
              }
            },
            icon: const Icon(Icons.add),
          ),
          const MainPopUpMenuButton()
        ],
      ),
    );
  }
}

class RemindersListView extends StatelessWidget {
  const RemindersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final appstate = context.watch<AppState>();
    return Observer(
      builder: (context) => ListView.builder(
        itemCount: appstate.reminder.length,
        itemBuilder: (context, index) {
          final reminder = appstate.reminder[index];
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: reminder.isDone,
            onChanged: (isDone) {
              context.read<AppState>().modify(
                    reminder,
                    isDone: isDone ?? false,
                  );
              reminder.isDone = isDone ?? false;
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    reminder.text,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final isDelete =
                        await showDeleteReminderDialog(context: context);
                    if (isDelete) {
                      context.read<AppState>().delete(reminder);
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

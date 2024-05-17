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
      body: const RemindersListView(),
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
          return Observer(builder: (context) {
            // return ListTile(
            //     leading: IconButton(
            //       onPressed: () {
            //         appstate.modify(reminder, isDone: !reminder.isDone);
            //       },
            //       icon: reminder.isDone
            //           ? const Icon(Icons.check_box)
            //           : const Icon(Icons.check_box_outline_blank_outlined),
            //     ),
            //     title: Text(
            //       reminder.text,
            //       style: const TextStyle(color: Colors.yellow),
            //     ));
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: reminder.isDone,
              onChanged: (isDone) async {
                if (isDone != null) {
                  appstate.modify(
                    reminder,
                    isDone: !reminder.isDone,
                  );
                }
              },
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      reminder.text,
                      style: const TextStyle(color: Colors.yellow),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final isDelete =
                          await showDeleteReminderDialog(context: context);
                      if (isDelete) {
                        appstate.delete(reminder);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  )
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

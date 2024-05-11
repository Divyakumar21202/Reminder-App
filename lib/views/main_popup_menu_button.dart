import 'package:flutter/material.dart';
import 'package:mobx_flutter/dialogs/delete_account_dialog.dart';
import 'package:mobx_flutter/dialogs/logout_dialog.dart';
import 'package:mobx_flutter/state/app_state.dart';
import 'package:provider/provider.dart';

enum MENUBUTTON { logout, delete }

class MainPopUpMenuButton extends StatelessWidget {
  const MainPopUpMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case MENUBUTTON.logout:
            final shouldLogout = await showlogOutDialog(context);
            if (shouldLogout) {
              context.read<AppState>().logOut();
            }
            break;
          case MENUBUTTON.delete:
            final shouldDelete = await showDeleteAccountDialog(context);
            if(shouldDelete){
              context.read<AppState>().deleteAccount();
            }
            break;
        }
      },
      itemBuilder: ((context) {
        return [
          const PopupMenuItem<MENUBUTTON>(
            value: MENUBUTTON.logout,
            child: Text('Logout'),
          ),
          const PopupMenuItem<MENUBUTTON>(
            value: MENUBUTTON.delete,
            child: Text('Delete'),
          )
        ];
      }),
    );
  }
}

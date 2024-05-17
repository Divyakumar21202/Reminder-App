import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_flutter/dialogs/auth_error_dialog.dart';
import 'package:mobx_flutter/firebase_options.dart';
import 'package:mobx_flutter/loading/loading_screen.dart';
import 'package:mobx_flutter/state/app_state.dart';
import 'package:mobx_flutter/views/login_view.dart';
import 'package:mobx_flutter/views/register_view.dart';
import 'package:mobx_flutter/views/reminders_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    Provider(
      create: (_) => AppState()..initialization(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: ReactionBuilder(
        builder: (context) { 
          return autorun((_) {
            final isLoading = context.read<AppState>().isLoading;
            if (isLoading) {
              LoadingScreen.instance()
                  .show(context: context, text: 'Loading ....');
            } else {
              LoadingScreen.instance().hide();
            }

            final authError = context.read<AppState>().authError;
            if (authError != null) {
              showAuthErrorDialog(context: context, authError: authError);
            }
          });
        },
        child: Observer(
          builder: (context) {
            switch (context.read<AppState>().currentScreen) {
              case AppScreen.loginScreen:
                return const LoginView();
              case AppScreen.registerScreen:
                return const RegisterView();
              case AppScreen.reminderScreen:
                return const RemindersView();
            }
          },
        ),
      ),
    );
  }
}

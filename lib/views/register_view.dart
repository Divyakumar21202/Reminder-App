import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobx_flutter/extensions/if_debugging.dart';
import 'package:mobx_flutter/state/app_state.dart';
import 'package:provider/provider.dart';

class RegisterView extends HookWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'pateldivyakumar123@gmail.com'.ifDebugging,
    );

    final passwordController = useTextEditingController(
      text: 'asdfghjkl'.ifDebugging,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter your email'),
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Enter Password'),
              obscureText: true,
              keyboardAppearance: Brightness.dark,
            ),
            TextButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  context
                      .read<AppState>()
                      .register(email: email, password: password);
                },
                child: const Text('Register')),
            TextButton(
              onPressed: () {
                context.read<AppState>().goTo(AppScreen.loginScreen);
              },
              child: const Text(
                'Already Registered ? Login here !',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
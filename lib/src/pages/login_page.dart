import 'package:dresscode/src/providers/auth_controller.dart';
import 'package:dresscode/src/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> login() => ref.read(authControllerProvider.notifier).login(
      'myEmail',
      'myPassword',
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),
            ActionButton(
              onPressed: login,
              icon: const SizedBox.shrink(),
              label: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
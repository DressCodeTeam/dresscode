import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 50)),
        backgroundColor: const WidgetStatePropertyAll(Colors.blue),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      onPressed: () {},
      child: const Text('Login',
          style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}

import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget{
  const LoginButton({ super.key });

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
        backgroundColor: WidgetStatePropertyAll(Colors.blue),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      onPressed: () {},
      child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
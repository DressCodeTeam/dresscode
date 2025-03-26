import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({ super.key });

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
        backgroundColor: WidgetStatePropertyAll(Colors.blue.withOpacity(0.5)),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      onPressed: () {},
      child: Text('Get Started', style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
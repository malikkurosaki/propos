import 'package:flutter/material.dart';

class CompLogout extends StatelessWidget {
  const CompLogout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Logout"),
      onPressed: () {
        
      },
    );
  }
}
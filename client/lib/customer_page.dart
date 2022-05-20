import 'package:client/comps/comp_app_bar.dart';
import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(child: Column(
        children: [
          CompAppBar(title: "customer"),
        ],
      )),
    );
  }
}
import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            CompAppBar(title: "setting"),
          
          ],
        ),
      ),
    );
  }
}
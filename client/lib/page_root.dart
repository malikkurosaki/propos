import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PageRoot extends StatelessWidget {
  const PageRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (a, b) => Material(
        color: Colors.cyan,
        child: SafeArea(
            child: Center(
          child: FutureBuilder(
            future: onLoad(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text("done");
              } else {
                return Text("loading");
              }
            },
          ),
        )),
      ),
    );
  }

  onLoad() async {
    await 0.1.delay();

    if (UtilPref.wellcome.value == "true") {
      UtilRoutes.wellcome().goOff();
      return;
    }

    if (UtilPref.user.isEmpty) {
      UtilRoutes.login().goOff();
      return;
    }

    UtilRoutes.home().goOff();
  }
}

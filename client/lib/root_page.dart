import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onLoad();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        UtilVal.isMobile.value = sizingInformation.isMobile;
        return Material(
          child: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  'assets/images/land.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  onLoad() async {
    await 0.01.delay();

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

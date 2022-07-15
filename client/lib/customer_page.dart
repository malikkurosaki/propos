import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Material(
          child: SafeArea(
            child: Column(
              children: [
                CompAppBar(title: "customer", onBack: () => UtilRoutes.home().go()),
                Flexible(
                  child: Row(
                    children: [
                      Visibility(
                        visible: !sizingInformation.isMobile,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          width: 340,
                          child: ListView(
                            children: const [
                              Text("Ini Apa Namanya")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: ListView(
                            children: const [
                              Text("Ini Apa Namanya kanan")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

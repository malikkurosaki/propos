import 'package:client/comps/comp_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PrinterPage extends StatelessWidget {
  const PrinterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Material(
          child: SafeArea(
            child: Column(
              children: const [
                CompAppBar(title: "printer"),
              ]
            ),
          ),
        );
      },
    );
  }
}
import 'dart:convert';

import 'package:client/cashier_sub_main.dart';
import 'package:client/cashier_sub_order.dart';
import 'package:client/util_conn.dart';
import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// final lastClick = <String, dynamic>{}.obs;

class CashierPage extends StatelessWidget {
  const CashierPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    onLoad();

    onLoad();
    return KeyboardDismisser(
      child: Material(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => SafeArea(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            UtilRoutes.home().go();
                          },
                        ),
                        Expanded(
                          child: Text(
                            "Cashier",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            color: Colors.blueGrey[50],
                            child: Obx(() => UtilPref.listMenu.isEmpty
                                ? Text("Loading ...")
                                : Visibility(
                                    visible: !sizingInformation.isMobile,
                                    child: CashierSubMain(),
                                  )),
                          ),
                        ),
                        Center(
                            child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 500), child: CashierSubOrder()))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onLoad() async {
    UtilPref.billIdSet("");
  }
}

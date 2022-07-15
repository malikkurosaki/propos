import 'dart:convert';
import 'dart:math';

import 'package:client/cashiers/cashier_page_saved_order.dart';
import 'package:client/cashiers/cashier_sub_main.dart';
import 'package:client/cashiers/cashier_sub_order.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_conn.dart';
import 'package:client/utils/util_value.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as anido;

// final lastClick = <String, dynamic>{}.obs;

class CashierPage extends StatelessWidget {
  const CashierPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // onLoad();
    return KeyboardDismisser(
      child: Material(
        color: Colors.white,
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => SafeArea(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(
                        color: Colors.grey.shade300
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey[700],
                            ),
                            onPressed: () {
                              UtilRoutes.home().go();
                            },
                          ),
                        ),
                        Text(
                          GVal.outlet.value.val['name'].toString().toUpperCase(),
                          style: const TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                        const CashierPageSavedOrder()
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: CashierSubMain()
                        ),
                        SizedBox(
                          width: sizingInformation.isMobile ? Get.width : 500,
                          child: CashierSubOrder(),
                        )
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

  // onLoad() async {
  //   UtilPref.billIdSet(value: "");
  // }
}

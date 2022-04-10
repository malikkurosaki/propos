import 'dart:convert';

import 'package:client/cashier_sub_main.dart';
import 'package:client/cashier_sub_order.dart';
import 'package:client/util_conn.dart';
import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// final lastClick = <String, dynamic>{}.obs;

class CashierPage extends StatelessWidget {
  const CashierPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    onLoad();
    return Material(
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
                      Visibility(
                        visible: !sizingInformation.isMobile,
                        child: Obx(() => Container(
                              color: Colors.brown[100],
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          UtilPref.isGridSet(!(UtilPref.isGrid.value == "true"));
                                        },
                                        icon: UtilPref.isGrid.value == "true"
                                            ? Icon(
                                                Icons.format_list_bulleted_outlined,
                                                color: Colors.cyan,
                                              )
                                            : Icon(
                                                Icons.grid_view_outlined,
                                                color: Colors.orange,
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              UtilPref.showFavoriteSet(!UtilPref.showFavorite.value);
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ),
                                        // badge fvorite length
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Visibility(
                                            visible: UtilPref.listFavorite.isNotEmpty,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 24,
                                              width: 24,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: UtilPref.showFavorite.value? Colors.blueGrey: Colors.pink,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child: Text(
                                                UtilPref.listFavorite.length.toString(),
                                                style: TextStyle(color: Colors.white, fontSize: 10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
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
    );
  }

  onLoad() async {}
}

import 'dart:convert';

import 'package:client/comps/comp_app_bar.dart';
import 'package:client/outlets/outlet_create.dart';
import 'package:client/outlets/outlet_detail.dart';
import 'package:client/outlets/outlet_table.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

import '../utils/util_http.dart';

class OutletPage extends StatelessWidget {
  const OutletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            children: [
              CompAppBar(
                title: "outlet",
                surfix: Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: UtilVal.devMode.value,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          UtilLoad.outlet(isAlert: true);
                        },
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !sizingInformation.isMobile,
                      child: Card(
                        child: SizedBox(
                          width: 340,
                          child: Obx(() => ListView(
                                children: [
                                  Ink(
                                    color: UtilPref.indexOutletPage.value == 0 ? Colors.grey[100] : Colors.transparent,
                                    child: ListTile(
                                      title: Text("List outlet"),
                                      onTap: () {
                                        UtilPref.indexOutletPageSet(value: 0);
                                      },
                                    ),
                                  ),
                                  Ink(
                                    color: UtilPref.indexOutletPage.value == 1 ? Colors.grey[100] : Colors.transparent,
                                    child: ListTile(
                                      title: Text("new outlet"),
                                      onTap: () {
                                        UtilPref.indexOutletPageSet(value: 1);
                                      },
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => IndexedStack(
                          sizing: StackFit.passthrough,
                          index: UtilPref.indexOutletPage.value,
                          children: [
                            OutletTable(),
                            OutletCreate(
                              onSave: (body) async {
                                final outlet = await UtilHttp.outletCreate(body!);
                                print(outlet.body);
                                try {
                                  final hasil = json.decode(outlet.body);
                                  if (hasil["success"]) {
                                    EasyLoading.showToast("Outlet created");
                                    UtilLoad.outlet();
                                  } else {
                                    EasyLoading.showToast("Failed to create outlet");
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

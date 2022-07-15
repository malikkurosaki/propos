import 'dart:convert';

import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

import '../utils/util_value.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  _onLoad() async {
    await UtilLoad.loadPaymentMethodMaster();
    await UtilLoad.loadPaymentMethod();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => Column(
          children: [
            CompAppBar(
              title: "Metode Pembayaran",
              surfix: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      EasyLoading.showInfo("masi dikerjakan");
                    },
                    icon: const Icon(Icons.add_circle)),
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    width: sizingInformation.isMobile ? Get.width / 2 : 340,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Obx(() => ListView(
                                controller: ScrollController(),
                                children: [
                                  for (final pmm in UtilValue.paymentMethodMasters)
                                    Visibility(
                                      visible: GVal.paymentMethods.value.val
                                              .indexWhere((element) => element['name'] == pmm['name']) ==
                                          -1,
                                      child: ListTile(
                                        title: Text(pmm['name'].toString()),
                                        trailing: const Icon(Icons.arrow_forward_ios),
                                        onTap: () async {
                                          final res = await UtilHttp.paymentMethodCreate(pmm);
                                          if (res.statusCode == 200) {
                                            UtilLoad.loadPaymentMethod();
                                          }
                                        },
                                      ),
                                    )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey[100],
                      width: 340,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "On Board",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Obx(
                              () => ListView(
                                controller: ScrollController(),
                                children: [
                                  for (final pmm in GVal.paymentMethods.value.val)
                                    ListTile(
                                      title: Text(pmm['name'].toString()),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          final res = await UtilHttp.paymentMethodDeleter(pmm['id']);
                                          if (res.statusCode == 200) {
                                            UtilLoad.loadPaymentMethod();
                                          }
                                        },
                                        icon: const Icon(Icons.remove_circle_outline),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
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
  }
}

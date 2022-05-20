import 'package:client/comps/comp_app_bar.dart';
import 'package:client/products/product_create.dart';
import 'package:client/products/product_table.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../utils/util_load.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);
  // final indexSub = 0.obs;

  _onLoad(){
    UtilLoad.category();
    UtilLoad.outlet();
    UtilLoad.product();
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompAppBar(
                title: "product",
                surfix: Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: UtilVal.devMode.value,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          UtilLoad.product(isAler: true);
                        },
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    Visibility(
                      visible: !sizingInformation.isMobile,
                      child: SizedBox(
                        width: sizingInformation.isMobile ? double.infinity : 320,
                        child: Card(
                          elevation: 0,
                          child: Column(
                            children: [
                              Flexible(
                                child: Obx(
                                  () => ListView(
                                    children: [
                                      Ink(
                                        color: UtilPref.indexProductPage.value == 0 ? Colors.grey[100] : Colors.transparent,
                                        child: ListTile(
                                          onTap: () => UtilPref.indexProductPageSet(value: 0),
                                          title: Text("Products"),
                                        ),
                                      ),
                                      Ink(
                                        color: UtilPref.indexProductPage.value == 1 ? Colors.grey[100] : Colors.transparent,
                                        child: ListTile(
                                          onTap: () => UtilPref.indexProductPageSet(value: 1),
                                          title: Text("Product Create"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => IndexedStack(
                          alignment: Alignment.topLeft,
                          index: UtilPref.indexProductPage.value,
                          children: [
                            ProductTable(),
                            ProductCreate(),
                          ],
                        ),
                      ),
                    )
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

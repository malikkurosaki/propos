import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client/homes/home_sub_info.dart';
import 'package:client/utils/util_conn.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_network/image_network.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as anido;
import 'package:http/http.dart' as http;

import '../products/comp_select_outlet.dart';

final listMenu = [
  ClassHomeMenu(
    color: Colors.blue[100],
    icon: Icons.home,
    title: "Home",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.pink[100],
    icon: Icons.local_convenience_store_rounded,
    title: "Cahier",
    onClick: () {
      Get.dialog(
        AlertDialog(
          title: Text("Login Success"),
          content: CompSelectOutlet(onSelect: (value) {
            UtilPref.outletSet(value: Map.from(value));
            UtilRoutes.cashier().go();
          }),
        ),
      );
    },
  ),
  ClassHomeMenu(
    color: Colors.cyan[100],
    icon: Icons.perm_contact_calendar_outlined,
    title: "Profile",
    onClick: () {
      UtilRoutes.profile().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.teal[100],
    icon: Icons.settings_suggest_rounded,
    title: "Setting",
    onClick: () {
      UtilRoutes.settingPage().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.green[100],
    icon: Icons.shopping_bag,
    title: "Product",
    onClick: () {
      UtilRoutes.productPage().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.brown[100],
    icon: Icons.store,
    title: "Outlet",
    onClick: () {
      UtilRoutes.outletPage().go();
    },
  ),
  ClassHomeMenu(
      color: Colors.pink[100],
      icon: Icons.local_printshop,
      title: "Printer",
      onClick: () {
        UtilRoutes.printerPage().go();
      }),
  ClassHomeMenu(
    color: Colors.orange[100],
    icon: Icons.update,
    title: "Update",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.purple[100],
    icon: Icons.add_chart_outlined,
    title: "Report",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.people,
    title: "Employee",
    onClick: () {
      UtilRoutes.employeePage().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.people,
    title: "List Transaction",
    onClick: () {
      UtilRoutes.transaction().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.people,
    title: "Category",
    onClick: () {
      UtilRoutes.categoryPage().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.contact_mail,
    title: "Customers",
    onClick: () {
      UtilRoutes.customerPage().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.developer_board,
    title: "Dev Page",
    onClick: () {
      UtilRoutes.devPage().go();
    },
  )
];

class ClassHomeMenu {
  final String? title;
  final IconData? icon;
  final Color? color;
  final Function()? onClick;

  ClassHomeMenu({this.title, this.icon, this.color, this.onClick});
}

final listSlideShow = [
  "https://user-images.githubusercontent.com/12760538/165197872-b40de9c0-4700-4c2a-8958-e73a0e5d541a.png",
  "https://user-images.githubusercontent.com/12760538/165197929-b4c17293-deb0-47f5-9d95-4503f0681e7b.png",
  "https://user-images.githubusercontent.com/12760538/165197963-b64d40c3-39ce-4195-bb7e-c7246622e1dc.png"
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  _onLoad() async {
    // if (UtilPref.outlet.isEmpty) {
    //   await UtilLoad.outlet(isAlert: true);
    // }

    // if (UtilPref.products.isEmpty) {
    //   await UtilLoad.product(isAler: true);
    // }

    // if (UtilPref.categories.isEmpty) {
    //   await UtilLoad.category(isAlert: true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: sizingInformation.isMobile ? 200 : 400,
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Center(
                          child: Icon(Icons.image, size: 100, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black45, Colors.transparent],
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/images/bg2.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UtilPref.user['name'].toString().toUpperCase(),
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey),
                                ),
                                // Text(
                                //   UtilPref.outlet['name'].toString(),
                                //   style: const TextStyle(
                                //     fontSize: 24,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.grey,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: sizingInformation.isMobile
                    ? sizingInformation.localWidgetSize.width / 3
                    : sizingInformation.localWidgetSize.width / 8,
                children: [
                  for (final item in listMenu)
                    anido.ElasticIn(
                      child: Card(
                        elevation: 0,
                        // color: item.color,
                        child: MaterialButton(
                          onPressed: item.onClick,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white54,
                                  child: Icon(
                                    item.icon,
                                    color: Colors.blue,
                                    size: 60,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

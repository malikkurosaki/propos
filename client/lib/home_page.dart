import 'package:client/home_sub_info.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart' as anido;

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
      UtilRoutes.cashier().go();
    },
  ),
  ClassHomeMenu(
    color: Colors.cyan[100],
    icon: Icons.perm_contact_calendar_outlined,
    title: "Profile",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.teal[100],
    icon: Icons.settings_suggest_rounded,
    title: "Setting",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.green[100],
    icon: Icons.shopping_bag,
    title: "Product",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.brown[100],
    icon: Icons.store,
    title: "Outlet",
    onClick: () {
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(color: Colors.pink[100], icon: Icons.local_printshop, title: "Printer", onClick: () {}),
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
      EasyLoading.showToast("masi dikerjain ...");
    },
  ),
  ClassHomeMenu(
    color: Colors.red[100],
    icon: Icons.people,
    title: "List Transaction",
    onClick: () {
      UtilRoutes.transaction().go();
    },
  )
  // {
  //   "title": "Home",
  //   "goTo": "/home",
  // },
  // {
  //   "title": "Cashier",
  //   "goTo": "/cashier",
  // },
  // {
  //   "title": "History",
  //   "goTo": "/history",
  // },
  // {
  //   "title": "Profile",
  //   "goTo": "/profile",
  // },
  // {
  //   "title": "Logout",
  //   "goTo": "/logout",
  // },
];

class ClassHomeMenu {
  final String? title;
  final IconData? icon;
  final Color? color;
  final Function()? onClick;

  ClassHomeMenu({this.title, this.icon, this.color, this.onClick});
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final isSideMenuOpen = true.obs;
  late AnimationController con;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(isSideMenuOpen.value.toString()),
              Container(
                color: Colors.blueGrey[100],
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Probus Pos",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                    Visibility(
                      visible: sizingInformation.isMobile,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Get.dialog(Material(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BackButton(),
                                  Flexible(child: HomeSubInfo()),
                                ],
                              )));
                            },
                            icon: Icon(Icons.notification_add, color: Colors.cyan)),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: Container(
                color: Colors.blueGrey[50],
                child: Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Visibility(
                          visible: !sizingInformation.isMobile && isSideMenuOpen.value,
                          child: anido.ElasticInLeft(
                            child: SizedBox(
                              width: 230,
                              child: HomeSubInfo(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Builder(builder: (context) {
                            Widget ini = anido.ElasticIn(
                                child: CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  child: IconButton(
                                    onPressed: () {
                                      isSideMenuOpen.value = !isSideMenuOpen.value;
                                    },
                                    icon: isSideMenuOpen.value
                                        ? Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              );
                            
                            return isSideMenuOpen.value? ini: SizedBox(
                              child: ini,
                            );
                          }),
                        ),
                        Expanded(
                          child: GridView.extent(
                            maxCrossAxisExtent: Get.width * 0.2,
                            children: [
                              for (final item in listMenu)
                                anido.ElasticIn(
                                  child: Card(
                                    color: item.color,
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
                                                color: Colors.teal[100],
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
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }

  onLoad() async {}
}

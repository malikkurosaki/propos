import 'package:client/home_sub_info.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

final listMenu = [
  ClassHomeMenu(color: Colors.blue[100], icon: Icons.home, title: "Home", onClick: () {
    EasyLoading.showToast("masi dikerjain ...");
  }),
  ClassHomeMenu(
    color: Colors.pink[100],
    icon: Icons.local_convenience_store_rounded,
    title: "Cahier",
    onClick: () {
      UtilRoutes.cashier().go();
    },
  ),
  ClassHomeMenu(color: Colors.cyan[100], icon: Icons.perm_contact_calendar_outlined, title: "Profile", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.teal[100], icon: Icons.settings_suggest_rounded, title: "Setting", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.green[100], icon: Icons.shopping_bag, title: "Product", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.brown[100], icon: Icons.store,title: "Outlet", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.pink[100], icon: Icons.local_printshop, title: "Printer", onClick: () {}),
  ClassHomeMenu(color: Colors.orange[100], icon: Icons.update, title: "Update", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.purple[100], icon: Icons.add_chart_outlined, title: "Report", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      }),
  ClassHomeMenu(color: Colors.red[100], icon: Icons.people, title: "Employee", onClick: () {
        EasyLoading.showToast("masi dikerjain ...");
      })
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
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://d39l2hkdp2esp1.cloudfront.net/img/eps/E3740_2x/c/E3740_05.jpg?20170928201051"),
                      fit: BoxFit.cover),
                ),
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
                        child: IconButton(onPressed: () {
                          Get.dialog(
                            Material(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BackButton(),
                                  Flexible(child: HomeSubInfo()),
                                ],
                              )
                            )
                          );
                        }, icon: Icon(Icons.notification_add, color: Colors.cyan)),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  child: Container(
                color: Colors.blueGrey[50],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !sizingInformation.isMobile,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 280),
                        child: HomeSubInfo(),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: sizingInformation.isMobile ? 500 : Get.width - 280,
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Wrap(
                            children: [
                              for (var item in listMenu)
                                Card(
                                  color: item.color,
                                  child: MaterialButton(
                                    onPressed: item.onClick,
                                    child: SizedBox(
                                      width: 200,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.black26,
                                            child: Icon(
                                              item.icon,
                                              color: Colors.white70,
                                              size: 60,
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                item.title.toString(),
                                                style: TextStyle(
                                                    fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black45),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  onLoad() async {}
}

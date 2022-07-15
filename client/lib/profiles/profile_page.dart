import 'dart:convert';

import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../comps/comp_app_bar.dart';
import '../utils/util_value.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => SafeArea(
          child: Column(
            children: [
               CompAppBar(
                title: "profile",
                onBack: () => UtilRoutes.home().go(),
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
                          child: ListView(children: [
                            Container(
                              height: 200,
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.grey[400],
                                          child: const Icon(Icons.person, size: 60, color: Colors.white)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      GVal.user.value.val['name'].toString(),
                                      style: const TextStyle(fontSize: 24, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.exit_to_app),
                              title: const Text("Logout"),
                              onTap: () {
                                // dialog logout
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("Logout"),
                                    content: const Text("Are you sure want to logout?"),
                                    actions: [
                                      MaterialButton(
                                        child: const Text("Yes"),
                                        onPressed: () async {
                                          // UtilValue.tokenSet(value: "");
                                          // GVal.user.value.val = {};
                                          // GVal.user.refresh();
                                          // GVal.listOrders.value.val = [];
                                          // GVal.listOrders.refresh();
                                          // GVal.outlets.value.val = [];
                                          // GVal.outlets.refresh();
                                          // GVal.customers.value.val = [];
                                          // GVal.customers.refresh();
                                          // UtilRoutes.root().goOff();
                                          GVal.clear();
                                          UtilRoutes.root().goOff();
                                        },
                                      ),
                                      MaterialButton(
                                        child: const Text("No"),
                                        onPressed: () => Get.back(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(8),
                          //   color: Colors.grey[100],
                          //   child: Row(
                          //     children: [
                          //       CircleAvatar(
                          //         backgroundColor: Colors.white,
                          //         child: BackButton(
                          //           onPressed: () => UtilRoutes.home().go(),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.only(left: 8),
                          //         child: Text(
                          //           "profile",
                          //           style: TextStyle(
                          //             fontSize: 32,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const Text("saya profile page"),
                          // edit profile
                          // ListTile(
                          //   leading: Icon(Icons.edit),
                          //   title: Text("Edit Profile"),
                          //   onTap: () {},
                          // ),
                          // logout
                          // ListTile(
                          //   leading: Icon(Icons.exit_to_app),
                          //   title: Text("Logout"),
                          //   onTap: () {
                          //     // dialog logout
                          //     Get.dialog(
                          //       AlertDialog(
                          //         title: Text("Logout"),
                          //         content: Text("Are you sure want to logout?"),
                          //         actions: [
                          //           MaterialButton(
                          //             child: Text("Yes"),
                          //             onPressed: () async {
                          //               UtilPref.tokenSet(value: "");
                          //               UtilPref.userSet(value: {});
                          //               UtilRoutes.root().goOff();
                          //             },
                          //           ),
                          //           MaterialButton(
                          //             child: Text("No"),
                          //             onPressed: () => Get.back(),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),
                        ],
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

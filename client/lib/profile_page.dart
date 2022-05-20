import 'dart:convert';

import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'comps/comp_app_bar.dart';
import 'utils/util_pref.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Material(
        child: SafeArea(
          child: Column(
            children: [
              CompAppBar(
                title: "profile",
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
                          child: ListView(
                            children: [
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
                                          child: Icon(Icons.person, size: 60, color: Colors.white)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        UtilPref.user['name'].toString(),
                                        style: TextStyle(fontSize: 24, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              
                            ]
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text("Logout"),
                            onTap: () {
                              // dialog logout
                              Get.dialog(
                                AlertDialog(
                                  title: Text("Logout"),
                                  content: Text("Are you sure want to logout?"),
                                  actions: [
                                    MaterialButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        UtilPref.tokenSet(value: "");
                                        UtilPref.userSet(value: {});
                                        UtilRoutes.root().goOff();
                                      },
                                    ),
                                    MaterialButton(
                                      child: Text("No"),
                                      onPressed: () => Get.back(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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
                          Text("saya profile page"),
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

import 'package:client/page_root.dart';
import 'package:client/util_conn.dart';
import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  UtilConn().loadMenuItem();
  UtilConn().loadCustomer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Propos',
        defaultTransition: Transition.noTransition,
        initialRoute: UtilRoutes.root().key,
        getPages: UtilRoutes.listPage,
        builder: EasyLoading.init());
  }
}

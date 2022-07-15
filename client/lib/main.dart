import 'package:client/cashiers/cashier_page_payment.dart';
import 'package:client/utils/util_conn.dart';
import 'package:client/utils/util_value.dart';
import 'package:client/utils/util_routers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

void main() async {
  await GetStorage.init();
  
  // final id = const Uuid().v4();
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // final info = {};
  // if (GetPlatform.isAndroid) {
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   info['id'] = id;
  //   info['model'] = androidInfo.model;
  //   info['version'] = androidInfo.version.release;
  //   info['manufacturer'] = androidInfo.manufacturer;
  //   info['brand'] = androidInfo.brand;
  //   info['device'] = androidInfo.id;
  // } else if (GetPlatform.isWeb) {
  //   WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
  //   info['id'] = id;
  //   info['model'] = webInfo.appName;
  //   info['version'] = webInfo.appVersion;
  //   info['manufacturer'] = webInfo.vendor;
  //   info['brand'] = webInfo.vendor;
  //   info['device'] = webInfo.userAgent;
  // } else{
  //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //   info['id'] = id;
  //   info['model'] = 'undifined';
  //   info['version'] = 'undifined';
  //   info['manufacturer'] = 'undifined';
  //   info['brand'] = 'undifined';
  //   info['device'] = 'undifined';
  // }

  // if (UtilValue.deviceInfo.isEmpty) {
  //   UtilValue.deviceInfoSet(value: Map.from(info));
  // }

  
  // UtilConn().loadMenuItem();
  // UtilConn().loadCustomer();
  // WidgetsFlutterBinding.ensureInitialized();
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
      builder: EasyLoading.init(),
    );
  }
}



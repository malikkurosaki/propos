import 'package:client/page_home.dart';
import 'package:client/page_root.dart';
import 'package:get/route_manager.dart';
import 'page_cashier.dart';
import 'page_edit_profile.dart';
import 'page_login.dart';
import 'page_profile.dart';
import 'page_register.dart';
import 'page_wellcome.dart';
import 'package:get/get.dart';

class UtilRoutes {
  late String key;

  UtilRoutes.root() : key = '/';
  UtilRoutes.home() : key = '/home';
  UtilRoutes.login() : key = '/login';
  UtilRoutes.register() : key = '/register';
  UtilRoutes.profile() : key = '/profile';
  UtilRoutes.editProfile() : key = '/editProfile';
  UtilRoutes.wellcome() : key = '/wellcome';
  UtilRoutes.cashier() : key = '/cashier';

  static final listPage = <GetPage>[
    GetPage(name: UtilRoutes.root().key, page: () => PageRoot()),
    GetPage(name: UtilRoutes.home().key, page: () => PageHome()),
    GetPage(name: UtilRoutes.login().key, page: () => PageLogin()),
    GetPage(name: UtilRoutes.register().key, page: () => PageRegister()),
    GetPage(name: UtilRoutes.profile().key, page: () => PageProfile()),
    GetPage(name: UtilRoutes.editProfile().key, page: () => PageEditProfile()),
    GetPage(name: UtilRoutes.wellcome().key, page: () => PageWellcome()),
    GetPage(name: UtilRoutes.cashier().key, page: () => PageCashier()),
  ];

  go() => Get.toNamed(key);
  goOff() => Get.offNamed(key);
  goOffAll() => Get.offAllNamed(key);
}

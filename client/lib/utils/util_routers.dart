import 'package:client/customer_page.dart';
import 'package:client/homes/home_page.dart';
import 'package:client/root_page.dart';
import 'package:client/printer_page.dart';
import 'package:client/profile_page.dart';
import 'package:client/setting_page.dart';
import 'package:get/route_manager.dart';
import '../cashiers/cashier_page.dart';
import '../cashiers/cashier_page_payment.dart';
import '../categories/category_page.dart';
import '../dev_page.dart';
import '../employee_page.dart';
import '../outlets/outlet_page.dart';
import '../profile_edit.dart';
import '../login_page.dart';
import '../register_page.dart';
import '../products/product_page.dart';
import '../wellcome_page.dart';
import 'package:get/get.dart';

import '../transaction_page.dart';

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
  UtilRoutes.cashierPayment() : key = '/cashierPayment';
  UtilRoutes.transaction() : key = '/transaction';
  UtilRoutes.productPage() : key = '/productPage';
  UtilRoutes.categoryPage() : key = '/categoryPage';
  UtilRoutes.printerPage() : key = '/printerPage';
  UtilRoutes.outletPage() : key = '/outletPage';
  UtilRoutes.employeePage() : key = '/employeePage';
  UtilRoutes.settingPage() : key = '/settingPage';
  UtilRoutes.customerPage() : key = '/customerPage';
  UtilRoutes.devPage() : key = '/devPage';

  static final listPage = <GetPage>[
    GetPage(name: UtilRoutes.root().key, page: () => RootPage()),
    GetPage(name: UtilRoutes.home().key, page: () => HomePage()),
    GetPage(name: UtilRoutes.login().key, page: () => LoginPage()),
    GetPage(name: UtilRoutes.register().key, page: () => RegisterPage()),
    GetPage(name: UtilRoutes.profile().key, page: () => ProfilePage()),
    GetPage(name: UtilRoutes.editProfile().key, page: () => ProfileEdit()),
    GetPage(name: UtilRoutes.wellcome().key, page: () => WellcomePage()),
    GetPage(name: UtilRoutes.cashier().key, page: () => CashierPage()),
    GetPage(name: UtilRoutes.cashierPayment().key, page: () => CashierPagePayment()),
    GetPage(name: UtilRoutes.transaction().key, page: () => TransactionPage()),
    GetPage(name: UtilRoutes.productPage().key, page: () => ProductPage()),
    GetPage(name: UtilRoutes.categoryPage().key, page: () => CategoryPage()),
    GetPage(name: UtilRoutes.printerPage().key, page: () => PrinterPage()),
    GetPage(name: UtilRoutes.outletPage().key, page: () => OutletPage()),
    GetPage(name: UtilRoutes.employeePage().key, page: () => EmployeePage()),
    GetPage(name: UtilRoutes.settingPage().key, page: () => SettingPage()),
    GetPage(name: UtilRoutes.customerPage().key, page: () => CustomerPage()),
    GetPage(name: UtilRoutes.devPage().key, page: () => DevPage()),
  ];

  go() => Get.toNamed(key);
  goOff() => Get.offNamed(key);
  goOffAll() => Get.offAllNamed(key);
}

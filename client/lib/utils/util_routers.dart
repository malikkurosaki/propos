import 'package:client/cashiers/cashier_page_payment_finish.dart';
import 'package:client/customer_page.dart';
import 'package:client/homes/home_page.dart';
import 'package:client/payment_metod/payment_method_page.dart';
import 'package:client/root_page.dart';
import 'package:client/printer_page.dart';
import 'package:client/profiles/profile_page.dart';
import 'package:client/setting_page.dart';
import 'package:get/route_manager.dart';
import '../cashiers/cashier_page.dart';
import '../cashiers/cashier_page_payment.dart';
import '../categories/category_page.dart';
import '../dev_page.dart';
import '../employees/employee_page.dart';
import '../outlets/outlet_page.dart';
import '../profiles/profile_edit.dart';
import '../logins/login_page.dart';
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

  // payment finish
  UtilRoutes.paymentFinish() : key = '/paymentFinish';

  // payment method page
  UtilRoutes.paymentMethodPage() : key = '/paymentMethodPage';

  UtilRoutes.devPage() : key = '/devPage';

  static final listPage = <GetPage>[
    GetPage(name: UtilRoutes.root().key, page: () => const RootPage()),
    GetPage(name: UtilRoutes.home().key, page: () => HomePage()),
    GetPage(name: UtilRoutes.login().key, page: () => LoginPage()),
    GetPage(name: UtilRoutes.register().key, page: () => RegisterPage()),
    GetPage(name: UtilRoutes.profile().key, page: () => const ProfilePage()),
    GetPage(name: UtilRoutes.editProfile().key, page: () => const ProfileEdit()),
    GetPage(name: UtilRoutes.wellcome().key, page: () => const WellcomePage()),
    GetPage(name: UtilRoutes.cashier().key, page: () => const CashierPage()),
    GetPage(name: UtilRoutes.cashierPayment().key, page: () => CashierPagePayment()),
    GetPage(name: UtilRoutes.transaction().key, page: () => const TransactionPage()),
    GetPage(name: UtilRoutes.productPage().key, page: () => const ProductPage()),
    GetPage(name: UtilRoutes.categoryPage().key, page: () => const CategoryPage()),
    GetPage(name: UtilRoutes.printerPage().key, page: () => const PrinterPage()),
    GetPage(name: UtilRoutes.outletPage().key, page: () => const OutletPage()),
    GetPage(name: UtilRoutes.employeePage().key, page: () => EmployeePage()),
    GetPage(name: UtilRoutes.settingPage().key, page: () => const SettingPage()),
    GetPage(name: UtilRoutes.customerPage().key, page: () => const CustomerPage()),

    // payment method page
    GetPage(name: UtilRoutes.paymentMethodPage().key, page: () => const PaymentMethodPage()),
    GetPage(name: UtilRoutes.devPage().key, page: () => const DevPage()),

    // payment finish
    GetPage(name: UtilRoutes.paymentFinish().key, page: () => const CashierPagePaymentFinish()),
  ];

  go() => Get.toNamed(key);
  goOff() => Get.offNamed(key);
  goOffAll() => Get.offAllNamed(key);
}

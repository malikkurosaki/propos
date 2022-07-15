import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GVal {
  // payment
  static final paymentMethods = [].val("paymentMethods").obs;
  static final paymentMethod = {}.val("paymentMethod").obs;

  // product
  static final products = [].val("products").obs;
  static final product = {}.val("product").obs;

  // product backup
  static final productsBackup = [].val("backupProducts").obs;

  // customer
  static final customers = [].val("customers").obs;
  static final customer = {}.val("customer").obs;

  // outlets
  static final outlets = [].val("outlets").obs;
  static final outlet = {}.val("outlet").obs;

  // etc
  static final haveToPay = 0.val("haveToPay").obs;
  static final changeValue = 0.val("changeValue").obs;
  static final payValue = "0".val("payValue").obs;
  static final transactionId = "".val("transactionId").obs;
  static final pax = 0.val("pax").obs;

  // bill types
  static final billTypes = [].val("billTypes").obs;
  static final billType = {}.val("billType").obs;

  // employees
  static final employees = [].val("employees").obs;
  static final employee = {}.val("employee").obs;

  // listOrder
  static final listOrders = [].val("listOrders").obs;

  // users
  static final users = [].val("users").obs;
  static final user = {}.val("user").obs;

  // categories
  static final categories = [].val("categories").obs;
  static final category = {}.val("category").obs;

  // saved orders
  static final savedOrders = [].val("savedOrders").obs;
  static final savedOrder = {}.val('savedOrder').obs;

  // token
  static final token = "".val("token").obs;

  static clear(){
    GetStorage().erase();
    Get.deleteAll();
  }

}

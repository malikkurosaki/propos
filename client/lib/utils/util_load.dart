import 'dart:convert';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'util_value.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UtilLoad {
  // load user
  static Future<void> loadUser({bool? isAlert = false}) async {
    if (isAlert!) {
      EasyLoading.show(status: "wait load user ...");
      await 1.delay();
    }
    final res = await UtilHttp.userGet();

 
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      GVal.user.value.val = Map.from(json['data']);
      GVal.user.refresh();

      if (isAlert) {
        EasyLoading.showSuccess("load user success");
        await 1.delay();
      }
    } else {
      if (isAlert) {
        EasyLoading.showError("load user failed");
        await 1.delay();
      }
    }
  }

  // load outlet
  static loadOutlet({bool? isAlert = false}) async {
    if (isAlert!) {
      EasyLoading.show(status: "wait load outlet ...");
      await 1.delay();
    }

    final value = await UtilHttp.outletGet();
    try {
      final hasil = json.decode(value.body);
      if (hasil['success']) {
        // UtilValue.outletsSet(value: List.from(jsonDecode(value.body)['data']));
        GVal.outlets.value.val = List.from(jsonDecode(value.body)['data']);
        GVal.outlets.refresh();
        if (isAlert) {
          EasyLoading.showSuccess('data loaded successfully');
          await 1.delay();
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      print(e.toString());
      if (isAlert) {
        EasyLoading.showError('Outlet failed to load');
      }
    }
  }

  // load category
  static loadCategory({bool? isAlert = false}) async {
    if (isAlert!) {
      EasyLoading.show(status: "wait load category ...");
      await 1.delay();
    }
    final res = await UtilHttp.categoryGet();

    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      GVal.categories.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.categories.refresh();

      if (isAlert) {
        EasyLoading.showSuccess('data loaded successfully');
        await 1.delay();
        EasyLoading.dismiss();
      }
    }
  }

  // load product
  static loadProduct({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load product ...");
      await 1.delay();
    }

    final res = await UtilHttp.productGet();

    if (res.statusCode == 200) {
      final result = jsonDecode(res.body);
      GVal.products.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.productsBackup.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.products.refresh();

      if (isAler) {
        debugPrint(res.body.toString());
        EasyLoading.showSuccess('data loaded successfully');
        await 1.delay();
        EasyLoading.dismiss();
      }
    }
  }

  // load payment method master
  static loadPaymentMethodMaster({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load payment method master ...");
      await 1.delay();
    }

    final res = await UtilHttp.paymentMethodMasterGet();
    if (res.statusCode == 200) {
      UtilValue.paymentMethodMastersSet(value: List.from(jsonDecode(res.body)['data']));
    }
  }

  // load payment methods
  static loadPaymentMethod({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load payment method ...");
      await 1.delay();
    }
    final res = await UtilHttp.paymentMethodGet();
    // debugPrint(res.body);
    if (res.statusCode == 200) {
      // UtilValue.paymentMethodsSet(value: List.from(jsonDecode(res.body)['data']));
      GVal.paymentMethods.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.paymentMethods.refresh();

      if (GVal.paymentMethods.value.val.isNotEmpty && GVal.paymentMethod.value.val.isEmpty) {
        GVal.paymentMethod.value.val = GVal.paymentMethods.value.val[0];
        GVal.paymentMethod.refresh();
      }
    }
  }

  // customer
  static loadCustomer({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load customer ...");
      await 1.delay();
    }
    final res = await UtilHttp.customerGet();
    if (res.statusCode == 200) {
      GVal.customers.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.customer.refresh();

      if (isAler) {
        EasyLoading.showSuccess('data loaded successfully');
        await 1.delay();
        EasyLoading.dismiss();
      }
    }
  }

  // employee get
  static loadEmployee({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load employee ...");
      await 1.delay();
    }
    final res = await UtilHttp.employeeGet();
    if (res.statusCode == 200) {
      GVal.employees.value.val = List.from(jsonDecode(res.body)['data']);
      GVal.employee.refresh();

      if (isAler) {
        debugPrint(res.body.toString());
        EasyLoading.showSuccess('data loaded successfully');
        await 1.delay();
        EasyLoading.dismiss();
      }
    }
  }

  static loadAll() async {
    await loadUser(isAlert: true);
    await loadOutlet(isAlert: true);
    await loadCategory(isAlert: true);
    await loadProduct(isAler: true);
    await loadPaymentMethodMaster(isAler: true);
    await loadPaymentMethod(isAler: true);
    await loadCustomer(isAler: true);
    await loadEmployee(isAler: true);
  }
}

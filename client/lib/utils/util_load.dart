import 'dart:convert';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'util_pref.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class UtilLoad {
  // load outlet
  static outlet({bool? isAlert = false}) async {
    if (isAlert!) {
      EasyLoading.show(status: "wait load outlet ...");
      await 1.delay();
    }

    final value = await UtilHttp.outletGet();
    try {
      final hasil = json.decode(value.body);
      if (hasil['success']) {
        UtilPref.outletsSet(value: List.from(jsonDecode(value.body)['data']));
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
  static category({bool? isAlert = false}) async {
    if (isAlert!) {
      EasyLoading.show(status: "wait load category ...");
      await 1.delay();
    }
    final value = await UtilHttp.categoryGet();

    print(value.body);

    try {
      final result = json.decode(value.body);
      if (result['success']) {
        UtilPref.listCategorySet(value: List.from(jsonDecode(value.body)['data']));
        if (isAlert) {
          EasyLoading.showSuccess('data loaded successfully');
          await 1.delay();
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      print(e);
      if (isAlert) {
        EasyLoading.showError('Category failed to load');
      }
    }
  }

  // load product
  static product({bool isAler = false}) async {
    if (isAler) {
      EasyLoading.show(status: "wait load product ...");
      await 1.delay();
    }
    final value = await UtilHttp.productGet();
    try {
      final result = jsonDecode(value.body);
      print(result);
      
      if (result['success']) {
        UtilPref.productsSet(value: List.from(jsonDecode(value.body)['data']));
        if (isAler) {
          EasyLoading.showSuccess('data loaded successfully');
          await 1.delay();
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      print(e);
      if (isAler) {
        EasyLoading.showError('Product failed to load');
      }
    }
  }
}

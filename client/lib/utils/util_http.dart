import 'package:client/utils/util_routers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'g_val.dart';
import 'util_value.dart';

class UtilHttp {
  static const host = "http://192.168.192.113:3000";
  static const hostApi = 'http://192.168.192.113:3000/api/v1';
  static const hostImage = "http://192.168.192.113:3000/image";
  static final hostImageWithUser = "http://192.168.192.113:3000/image/${GVal.user.value.val['id']}/";

  // register
  Future<http.Response> register(Map? body) => http.post(Uri.parse(host + '/register'), body: body);

  // login
  Future<http.Response> login(Map? body) => http.post(Uri.parse(host + '/login'), body: body);

  // check token
  static Future<http.Response> _checkToken(Future<http.Response> res) async {
    final response = await res;
    if (response.statusCode == 401) {
      EasyLoading.showError("Token expired");
      await UtilValue.clear();
      await 2.delay();
      UtilRoutes.login().goOffAll();
      await 1.delay();
      return response;
    }
    return response;
  }

  // Outlet
  // create outlet
  static Future<http.Response> outletCreate(Map body) => http.post(
        Uri.parse(hostApi + '/outlet/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // get outlet
  static Future<http.Response> outletGet() => http.get(
        Uri.parse(hostApi + '/outlet/get/'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // update outlet
  static Future<http.Response> outletUpdate(Map body) => http.post(
        Uri.parse(hostApi + '/outlet/update'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // delete outlet
  static Future<http.Response> outletDelete(String id) => http.delete(
        Uri.parse(hostApi + '/outlet/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // Category
  // create category
  static Future<http.Response> categoryCreate(Map body) => http.post(
        Uri.parse(hostApi + '/category/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // get category
  static Future<http.Response> categoryGet() => http.get(
        Uri.parse(hostApi + '/category/get/'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // update category
  static Future<http.Response> categoryUpdate(Map body, String id) => http.post(
        Uri.parse(hostApi + '/category/update/$id'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // delete category
  static Future<http.Response> categoryDelete(String id) => http.delete(
        Uri.parse(hostApi + '/category/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // Product
  // create product
  static Future<http.Response> productCreate(Map body) => _checkToken(http.post(
        Uri.parse(hostApi + '/product/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      ));

  // get product
  static Future<http.Response> productGet() => http.get(
        Uri.parse(hostApi + '/product/get/'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // update product
  static Future<http.Response> productUpdate(Map body, String id) => http.post(
        Uri.parse(hostApi + '/product/update/$id'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // delete product
  static Future<http.Response> productDelete(String id) => http.delete(
        Uri.parse(hostApi + '/product/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // user get
  static Future<http.Response> userGet() => http.get(
        Uri.parse(hostApi + '/user/get/'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // development mode
  // User
  // user get
  // static Future<http.Response> userGet() => http.get(
  //       Uri.parse(host + '/user/'),
  //       headers: {
  //         "Authorization": "Bearer ${UtilValue.token}",
  //       },
  //     );

  static Future<http.Response> availableImage() => http.get(
        Uri.parse(hostApi + '/images'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // Logout
  static Future<http.Response> logout() => http.delete(
        Uri.parse(hostApi + '/logout'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // user load
  static Future<http.Response> userLoad() => http.get(
        Uri.parse(hostApi + '/user/load'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // payyment methhod create
  static Future<http.Response> paymentMethodCreate(Map body) => http.post(
        Uri.parse(hostApi + '/payment-method/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // payment method master get
  static Future<http.Response> paymentMethodMasterGet() => http.get(
        Uri.parse(hostApi + '/payment-method/master'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // payment method upsert
  static Future<http.Response> paymentMethodUpsert(Map body) => http.post(
        Uri.parse(hostApi + '/payment-method/upsert'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // payment method get
  static Future<http.Response> paymentMethodGet() => http.get(
        Uri.parse(hostApi + '/payment-method/get'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // payment method deleter
  static Future<http.Response> paymentMethodDeleter(String id) => http.delete(
        Uri.parse(hostApi + '/payment-method/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  static Future<http.Response> listbillBill(Map body) => http.post(
        Uri.parse(hostApi + '/listbill-bill/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // customer create
  static Future<http.Response> customerCreate(Map body) => http.post(
        Uri.parse(hostApi + '/customer/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // customer get
  static Future<http.Response> customerGet() => http.get(
        Uri.parse(hostApi + '/customer/get'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // employee create
  static Future<http.Response> employeeCreate(Map body) => http.post(
        Uri.parse(hostApi + '/employee/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );

  // employee get
  static Future<http.Response> employeeGet() => http.get(
        Uri.parse(hostApi + '/employee/get'),
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );
  // employee login
  static Future<http.Response> employeeLoginPin(Map body) => http.post(
        Uri.parse(host + '/login/employee'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilValue.token}",
        },
      );
}

import 'package:client/utils/util_routers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'util_pref.dart';

class UtilHttp {
  static const host = "http://localhost:3000";
  static const url = 'http://localhost:3000/api/v1';
  static const urlImage = "http://localhost:3000/image";
  static final urlImageWithUser = "http://localhost:3000/image/${ UtilPref.user['id']}/";

  // register
  Future<http.Response> register(Map? body) => http.post(Uri.parse(host + '/register'), body: body);

  // login
  Future<http.Response> login(Map? body) => http.post(Uri.parse(host + '/login'), body: body);

  // check token
  static Future<http.Response> _checkToken(Future<http.Response> res)async{
    final response = await res;
    if(response.statusCode == 401){
      EasyLoading.showError("Token expired");
      await UtilPref.clear();
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
        Uri.parse(url + '/outlet/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // get outlet
  static Future<http.Response> outletGet() => http.get(
        Uri.parse(url + '/outlet/get/'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // update outlet
  static Future<http.Response> outletUpdate(Map body) => http.post(
        Uri.parse(url + '/outlet/update'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // delete outlet
  static Future<http.Response> outletDelete(String id) => http.delete(
        Uri.parse(url + '/outlet/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // Category
  // create category
  static Future<http.Response> categoryCreate(Map body) => http.post(
        Uri.parse(url + '/category/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // get category
  static Future<http.Response> categoryGet() => http.get(
        Uri.parse(url + '/category/get/'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // update category
  static Future<http.Response> categoryUpdate(Map body, String id) => http.post(
        Uri.parse(url + '/category/update/$id'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // delete category
  static Future<http.Response> categoryDelete(String id) => http.delete(
        Uri.parse(url + '/category/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // Product
  // create product
  static Future<http.Response> productCreate(Map body) => _checkToken(http.post(
        Uri.parse(url + '/product/create'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      ));

  // get product
  static Future<http.Response> productGet() => http.get(
        Uri.parse(url + '/product/get/'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // update product
  static Future<http.Response> productUpdate(Map body, String id) => http.post(
        Uri.parse(url + '/product/update/$id'),
        body: body,
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // delete product
  static Future<http.Response> productDelete(String id) => http.delete(
        Uri.parse(url + '/product/delete/$id'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // development mode
  // User
  // user get
  static Future<http.Response> userGet() => http.get(
        Uri.parse(host + '/user/'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  static Future<http.Response> availableImage() => http.get(
        Uri.parse(url + '/images'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // Logout
  static Future<http.Response> logout() => http.delete(
        Uri.parse(url + '/logout'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );

  // user load
  static Future<http.Response> userLoad() => http.get(
        Uri.parse(url + '/user/load'),
        headers: {
          "Authorization": "Bearer ${UtilPref.token}",
        },
      );
}

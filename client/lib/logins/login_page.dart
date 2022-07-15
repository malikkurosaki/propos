import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/logins/login_by_pin.dart';
import 'package:client/products/comp_select_outlet.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_value.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:animate_do/animate_do.dart' as anido;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _body = <String, dynamic>{"email": "", "password": ""}.obs;
  
  final _hidePassword = true.obs;
  

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => KeyboardDismisser(
        child: SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: !sizingInformation.isMobile,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset('assets/images/logo.png'),
                    )),
                  ),
                ),
                SizedBox(
                  width: sizingInformation.isMobile ? double.infinity : 500,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Obx(
                      () => ListView(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/image1.png",
                                    fit: BoxFit.scaleDown,
                                    height: 200,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          "Login as Owner",
                                          style: TextStyle(
                                            fontSize: 32,
                                            color: Colors.grey[700],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Text("Lengkapi Data Diri Anda Yang DiDapatkan Ketika Mendaftar"),
                                      ),
                                    ],
                                  ),
                                ),
                                // ListTile(
                                //   title:
                                //   Text(
                                //     "Login as Owner",
                                //     style: TextStyle(
                                //       fontSize: 32,
                                //       color: Colors.grey[700],
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                //   subtitle:
                                //       Text("Lengkapi Data Diri Anda Yang DiDapatkan Ketika Mendaftar"),
                                // ),
                                ListTile(
                                  title: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      _body["email"] = value;
                                      _body['emailValid'] = !value.contains("@");
                                      _body.refresh();
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: "Email",
                                      fillColor: Colors.grey[50],
                                      prefixIcon: const Icon(Icons.email),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  subtitle: Visibility(
                                    child: const Text("Email is not valid"),
                                    visible: _body['emailValid'] ?? false,
                                  ),
                                ),
                                ListTile(
                                  title: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      _body["password"] = value;
                                      _body['passwordValid'] = value.length < 8;
                                      _body.refresh();
                                    },
                                    obscureText: _hidePassword.value,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Password",
                                      fillColor: Colors.grey[50],
                                      prefixIcon: const Icon(Icons.lock),
                                      filled: true,
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _hidePassword.value ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          _hidePassword.value = !_hidePassword.value;
                                          _body.refresh();
                                        },
                                      ),
                                    ),
                                  ),
                                  subtitle: Visibility(
                                    child: const Text("Password is not valid"),
                                    visible: _body['passwordValid'] ?? false,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  child: Card(
                                    color: Colors.cyan[50],
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(18),
                                            child: SizedBox(
                                              width: 100,
                                              height: 70,
                                              child: Image.asset(
                                                "assets/images/register.png",
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "jika anda belum terdaftar , silahkan mendaftar terlebih dahulu",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    color: Colors.cyan,
                                                    onPressed: () {
                                                      UtilRoutes.register().go();
                                                    },
                                                    child: const Text(
                                                      "Register",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                ListTile(
                                  title: MaterialButton(
                                    color: Colors.cyan,
                                    onPressed: () async {
                                      if (_body.values.contains("")) {
                                        EasyLoading.showError("Please fill all field");
                                        return;
                                      }

                                      final data = {
                                        "email": _body["email"],
                                        "password": _body["password"],
                                        "device": jsonEncode(UtilValue.deviceInfo),
                                      };

                                      final kirim = await UtilHttp().login(data);
                                      if(kirim.statusCode == 200){
                                        GVal.token.value.val = jsonDecode(kirim.body)["token"];
                                        await UtilLoad.loadAll();
                                        UtilRoutes.home().go();
                                      }
                                      // try {
                                      //   final hasil = Map.from(json.decode(kirim.body));
                                      //   if (hasil['success']) {
                                      //     // UtilValue.outletsSet(value: List.from(hasil['data']['Outlets']));
                                      //     GVal.outlets.value.val = List.from(hasil['data']['Outlets']);
                                      //     GVal.outlets.refresh();

                                      //     GVal.user.value.val = hasil['data'];
                                      //     GVal.user.refresh();

                                      //     UtilValue.tokenSet(value: hasil['token']);
                                      //     UtilRoutes.home().goOff();
                                      //   } else {
                                      //     EasyLoading.showError(hasil['message']);
                                      //   }
                                      // } catch (e) {
                                      //   print(e.toString());
                                      //   EasyLoading.showError("503 | login");
                                      // }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(14),
                                      child: const Center(
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          LoginByPin()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

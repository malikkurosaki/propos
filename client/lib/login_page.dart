import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/products/comp_select_outlet.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_pref.dart';
import 'package:client/utils/util_routers.dart';
import 'package:client/utils/util_val.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:animate_do/animate_do.dart' as anido;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final body = <String, dynamic>{"email": "", "password": ""}.obs;
  final employee = "".obs;
  final hidePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Column(
        children: [
          Visibility(
              visible: UtilVal.devMode.value,
              child: IconButton(
                onPressed: () {
                  UtilHttp.userGet().then((value) => print(value.body));
                },
                icon: Icon(Icons.developer_mode),
              )),
          Flexible(
            child: Obx(
              () => Material(
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/land.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: Container(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                Flexible(
                                  child: ListView(
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
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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

                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 16 ),
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
                                                  body["email"] = value;
                                                  body['emailValid'] = !value.contains("@");
                                                  body.refresh();
                                                },
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  labelText: "Email",
                                                  hintText: "Email",
                                                  fillColor: Colors.grey[50],
                                                  prefixIcon: Icon(Icons.email),
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Visibility(
                                                child: Text("Email is not valid"),
                                                visible: body['emailValid'] ?? false,
                                              ),
                                            ),
                                            ListTile(
                                              title: TextFormField(
                                                textInputAction: TextInputAction.next,
                                                onChanged: (value) {
                                                  body["password"] = value;
                                                  body['passwordValid'] = value.length < 8;
                                                  body.refresh();
                                                },
                                                obscureText: hidePassword.value,
                                                decoration: InputDecoration(
                                                  labelText: "Password",
                                                  hintText: "Password",
                                                  fillColor: Colors.grey[50],
                                                  prefixIcon: Icon(Icons.lock),
                                                  filled: true,
                                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      hidePassword.value ? Icons.visibility : Icons.visibility_off,
                                                    ),
                                                    onPressed: () {
                                                      hidePassword.value = !hidePassword.value;
                                                      body.refresh();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              subtitle: Visibility(
                                                child: Text("Password is not valid"),
                                                visible: body['passwordValid'] ?? false,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(14),
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
                                                              Text(
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
                                                                child: Text(
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
                                            SizedBox(
                                              height: 24,
                                            ),
                                            ListTile(
                                              title: MaterialButton(
                                                color: Colors.cyan,
                                                onPressed: () async {
                                                  if (body.values.contains("")) {
                                                    EasyLoading.showError("Please fill all field");
                                                    return;
                                                  }

                                                  final data = {
                                                    "email": body["email"],
                                                    "password": body["password"],
                                                    "device": jsonEncode(UtilPref.deviceInfo),
                                                  };

                                                  final kirim = await UtilHttp().login(data);
                                                  try {
                                                    final hasil = Map.from(json.decode(kirim.body));
                                                    if (hasil['success']) {
                                                      UtilPref.outletsSet(value: List.from(hasil['data']['Outlets']));
                                                      UtilPref.userSet(value: hasil['data']);
                                                      UtilPref.tokenSet(value: hasil['token']);
                                                      UtilRoutes.home().goOff();
                                                      
                                                    } else {
                                                      EasyLoading.showError(hasil['message']);
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                    EasyLoading.showError("503 | login");
                                                  }
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(14),
                                                  child: Center(
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
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(children: [
                                            Text(
                                              'Login As Employee',
                                              style: TextStyle(
                                                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        obscureText: hidePassword.value,
                                                        textInputAction: TextInputAction.next,
                                                        onChanged: (value) {
                                                          employee.value = value;
                                                        },
                                                        keyboardType: TextInputType.emailAddress,
                                                        decoration: InputDecoration(
                                                          labelText: "PIN",
                                                          hintText: "Pin",
                                                          fillColor: Colors.grey[50],
                                                          prefixIcon: Icon(Icons.pending_sharp),
                                                          filled: true,
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide.none,
                                                          ),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(
                                                              hidePassword.value
                                                                  ? Icons.visibility
                                                                  : Icons.visibility_off,
                                                            ),
                                                            onPressed: () {
                                                              hidePassword.value = !hidePassword.value;
                                                              employee.refresh();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 24,
                                                      ),
                                                      MaterialButton(
                                                        color: Colors.teal,
                                                        onPressed: () {
                                                          print(employee);
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.all(12),
                                                          child: Center(
                                                            child: Text(
                                                              'Masuk',
                                                              style: TextStyle(color: Colors.white, fontSize: 18),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 200,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                    child: Image.asset(
                                                      "assets/images/emp.png",
                                                      fit: BoxFit.scaleDown,
                                                      height: 200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

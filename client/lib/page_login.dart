import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/util_pref.dart';
import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:animate_do/animate_do.dart' as anido;

class PageLogin extends StatelessWidget {
  PageLogin({Key? key}) : super(key: key);
  final body = {"email": "", "password": ""}.obs;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
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
              )),
              SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500),
                    child: anido.JelloIn(
                      child: Container(
                        color: Colors.cyan[100],
                        child: Column(
                          children: [
                            Flexible(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/image1.png",
                                      fit: BoxFit.scaleDown,
                                      height: 200,
                                    ),
                                  ),
                                  // Container(
                                  //   height: 300,
                                  //   child: CachedNetworkImage(
                                  //     imageUrl: "https://i.postimg.cc/d3FjrZsF/image.png",
                                  //     placeholder: (a, b) => Icon(Icons.image_search_rounded),
                                  //   ),
                                  // ),
                    
                                  ListTile(
                                    title: Text(
                                      "SIGNIN",
                                      style: TextStyle(fontSize: 32, color: Colors.cyan, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListTile(
                                    title: TextFormField(
                                      onChanged: (value) {
                                        body["email"] = value;
                                        body.refresh();
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          labelText: "Email",
                                          hintText: "Email",
                                          fillColor: Colors.cyan[50],
                                          prefixIcon: Icon(Icons.email),
                                          filled: true,
                                          border: InputBorder.none),
                                    ),
                                    subtitle:
                                        body['email'].toString().isNotEmpty && !body['email'].toString().contains("@")
                                            ? Text("Email is not valid")
                                            : null,
                                  ),
                                  ListTile(
                                    title: TextFormField(
                                      onChanged: (value) {
                                        body["password"] = value;
                                        body.refresh();
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          hintText: "Password",
                                          fillColor: Colors.cyan[50],
                                          prefixIcon: Icon(Icons.lock),
                                          filled: true,
                                          border: InputBorder.none),
                                    ),
                                    subtitle:
                                        body['password'].toString().isNotEmpty && body['password'].toString().length < 6
                                            ? Text("Password is not valid")
                                            : null,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                    
                                  Column(
                                    children: [
                                      Container(
                                        width: 300,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "jika anda belum terdaftar , silahkan mendaftar terlebih dahulu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.cyan),
                                        ),
                                      ),
                                      CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {
                                                UtilRoutes.register().go();
                                              },
                                              icon: Icon(Icons.signpost_rounded)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: MaterialButton(
                                color: Colors.cyan[700],
                                onPressed: () {
                                  if (body['email'] == "admin@gmail.com" && body['password'] == "admin") {
                                    UtilPref.userSet(value: body);
                                    UtilRoutes.home().goOff();
                                  } else {
                                    EasyLoading.showError("Email atau Password Salah");
                                  }
                                  // UtilRoutes.home().goOff();
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

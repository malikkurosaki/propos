import 'dart:convert';
import 'dart:ui';

import 'package:animate_do/animate_do.dart' as anido;
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'utils/util_routers.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final body = {}.obs;
  final validate = {}.obs;
  final hidePassword = true.obs;

  final formController = <String, TextEditingController>{
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "password2": TextEditingController(),
    "rolesId": TextEditingController(),
    "phone": TextEditingController(),
    "outletName": TextEditingController(),
  };

  void validasi(String res) {
    const errorEmail = 'Users_email_key';
    const errorName = 'Users_name_key';
    final dataUser = Map.from(jsonDecode(res));

    if (dataUser['success']) {
      EasyLoading.showSuccess('Register Success');
      UtilRoutes.login().goOff();
    } else {
      EasyLoading.showError(dataUser.toString());
      if (dataUser['message']['meta']['target'] == errorEmail) {
        EasyLoading.showError('Email Already Exist');
      } else if (dataUser['message']['meta']['target'] == errorName) {
        EasyLoading.showError('Name Already Exist');
      } else {
        EasyLoading.showError(dataUser.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade200,
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                padding: EdgeInsets.all(16),
                width: sizingInformation.isMobile ? double.infinity : 500,
                child: Obx(
                  () => ListView(
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
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "REGISTER",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            const Text(
                              "Lengkapi Data Date DiBawah Ini Dengan Lengkap Untuk Melanjutkan Ke Proses Selanjutnya",
                              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        isThreeLine: true,
                        title: TextFormField(
                          controller: formController['name'],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            body['name'] = value;
                            body['nameValid'] = body['name'].toString().isEmpty ||
                                body['name'].toString().isNotEmpty && body['name'].toString().length < 4;
                            body.refresh();
                          },
                          decoration: InputDecoration(
                              labelText: "username",
                              hintText: "username",
                              fillColor: Colors.grey[50],
                              prefixIcon: const Icon(Icons.people),
                              filled: true,
                              border: const OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "username is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['nameValid'] ?? false,
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: formController['email'],
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            body['email'] = value;
                            body['emailValid'] = body['email'].toString().isEmpty ||
                                body['email'].toString().isNotEmpty && !body['email'].toString().contains("@");
                            body.refresh();
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Email",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.email),
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "Email is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['emailValid'] ?? false,
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: formController['password'],
                          obscureText: hidePassword.value,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            body['password'] = value;
                            body['passwordValid'] = body['password'].toString().isEmpty ||
                                body['password'].toString().isNotEmpty && body['password'].toString().length < 6;
                            body.refresh();
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Password",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword.value ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                hidePassword.value = !hidePassword.value;
                              },
                            ),
                          ),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "Password is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['passwordValid'] ?? false,
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: formController['password2'],
                          obscureText: hidePassword.value,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            body['password2'] = value;
                            body['password2Valid'] = body['password2'].toString().isEmpty ||
                                body['password2'].toString().isNotEmpty &&
                                    body['password2'].toString() != body['password'].toString();
                            body.refresh();
                          },
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword.value ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                hidePassword.value = !hidePassword.value;
                              },
                            ),
                          ),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "Password is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['password2Valid'] ?? false,
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: formController['phone'],
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            body['phone'] = value;
                            body['phoneValid'] = body['phone'].toString().isEmpty ||
                                body['phone'].toString().isNotEmpty && body['phone'].toString().length < 10;
                            body.refresh();
                          },
                          decoration: InputDecoration(
                            labelText: "Phone",
                            hintText: "Phone",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.phone),
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "Phone is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['phoneValid'] ?? false,
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: formController['outletName'],
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            body['outlet'] = value;
                            body['outletValid'] = body['outlet'].toString().isEmpty ||
                                body['outlet'].toString().isNotEmpty && body['outlet'].toString().length < 4;
                            body.refresh();
                          },
                          decoration: InputDecoration(
                            labelText: "Outlet Name",
                            hintText: "Outlet",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.store),
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                        subtitle: Visibility(
                          child: Text(
                            "Outlet Name is required",
                            style: TextStyle(color: Colors.pink[200]),
                          ),
                          visible: body['outletValid'] ?? false,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        child: Card(
                          color: Colors.green[50],
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
                                          "Jika Anda Sudah Memliki Akun, Silahkan Login",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        MaterialButton(
                                          color: Colors.green,
                                          onPressed: () {
                                            UtilRoutes.login().go();
                                          },
                                          child: const Text(
                                            "Login",
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
                      ListTile(
                        title: MaterialButton(
                          color: Colors.green,
                          onPressed: () async {
                            formController['rolesId']!.text = "2";
                            if(formController.values.map((e) => e.text.isEmpty).contains(true)){
                              EasyLoading.showError("Please fill all the required fields");
                              return;
                            }

                             final data = {
                              "name": formController['name']!.text,
                              "email": formController['email']!.text,
                              "password": formController['password']!.text,
                              "phone": formController['phone']!.text,
                              "outlet": formController['outletName']!.text,
                              "device": "mobile",
                              "rolesId": formController['rolesId']!.text,
                            };

                            try {
                              final kirim = await UtilHttp().register(data);
                              validasi(kirim.body);
                            } catch (e) {
                              EasyLoading.showError(e.toString());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text("Register", style: TextStyle(color: Colors.grey[50], fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

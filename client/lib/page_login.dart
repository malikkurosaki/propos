import 'package:client/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageLogin extends StatelessWidget {
  PageLogin({Key? key}) : super(key: key);
  final body = {"email": "", "password": ""}.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Image.network("https://i.postimg.cc/d3FjrZsF/image.png", 
                          fit: BoxFit.cover,
                        ),

                      ),
                      SizedBox(height: 50,),
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
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              border: InputBorder.none),
                        ),
                        subtitle: body['email'].toString().isNotEmpty && !body['email'].toString().contains("@")
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
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.lock),
                              filled: true,
                              border: InputBorder.none),
                        ),
                        subtitle: body['password'].toString().isNotEmpty && body['password'].toString().length < 6
                            ? Text("Password is not valid")
                            : null,
                      ),
                      ListTile(
                        onTap: () {
                          UtilRoutes.register().go();
                        },
                        title: Text("Jika Anda Belum Memiliki Akun Silakan Register",
                            style: TextStyle(color: Colors.grey),
                            ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      SizedBox(height: 50,),
                      ListTile(
                        title: MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            UtilRoutes.home().go();
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

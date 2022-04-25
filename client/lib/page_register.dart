import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart' as anido;
import 'util_routers.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  color: Colors.green[100],
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
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "username",
                                    hintText: "username",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Email",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    hintText: "Password",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.lock),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    hintText: "Confirm Password",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.lock),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Phone",
                                    hintText: "Phone",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Outlet Name",
                                    hintText: "Outlet",
                                    fillColor: Colors.green[50],
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Jika Anda telah memilikai akun silakan login",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: (){
                                         UtilRoutes.login().go();
                                      }, 
                                      icon: Icon(Icons.login)
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: MaterialButton(
                          color: Colors.green[700],
                          onPressed: () {
                            UtilRoutes.login().go();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text("Register", style: TextStyle(color: Colors.green[50], fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

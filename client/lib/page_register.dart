import 'package:flutter/material.dart';

import 'util_routers.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
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
                      SizedBox(
                        width: 300,
                        child: Image.network(
                          "https://i.postimg.cc/d3FjrZsF/image.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                              labelText: "username",
                              hintText: "username",
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              border: InputBorder.none),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          UtilRoutes.login().go();
                        },
                        title: Text(
                          "Jika Anda telah memilikai akun silakan login",
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      UtilRoutes.login().go();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(child: Text("Register",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

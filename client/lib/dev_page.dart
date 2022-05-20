import 'dart:convert';

import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DevPage extends StatelessWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          CompAppBar(title: "Dev Page"),
          Text(
            "User Data",
            style: TextStyle(fontSize: 32),
          ),
          Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey[100],
              child: Text(JsonEncoder.withIndent("   ").convert(UtilPref.user))),
          Text(
            "Token Data",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Text(
              UtilPref.token.toString(),
            ),
          ),
          // user load
          Text(
            "User Load",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[100],
            child: FutureBuilder<http.Response>(
              future: UtilHttp.userLoad(),
              builder: (context, snapshot) =>
                  snapshot.connectionState != ConnectionState.done ? Text("loading") : Text(JsonEncoder.withIndent("  ").convert(jsonDecode(snapshot.data!.body))),
            ),
          ),
          // product
          Text(
            "Product Load",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey[100],
            child: FutureBuilder<http.Response>(
              future: UtilHttp.productGet(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                  ? Text("loading")
                  : Text(JsonEncoder.withIndent("  ").convert(jsonDecode(snapshot.data!.body))),
            ),
          )
        ],
      ),
    );
  }
}

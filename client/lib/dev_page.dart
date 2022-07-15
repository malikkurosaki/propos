import 'dart:convert';

import 'package:client/comps/comp_app_bar.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DevPage extends StatelessWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          const CompAppBar(title: "Dev Page"),
          const Text(
            "User Data",
            style: TextStyle(fontSize: 32),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey[100],
              child: Text(const JsonEncoder.withIndent("   ").convert(GVal.user.value.val))),
          const Text(
            "Token Data",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Text(
              UtilValue.token.toString(),
            ),
          ),
          // user load
          const Text(
            "User Load",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: FutureBuilder<http.Response>(
              future: UtilHttp.userLoad(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                  ? const Text("loading")
                  : Text(const JsonEncoder.withIndent("  ").convert(jsonDecode(snapshot.data!.body))),
            ),
          ),
          // product
          const Text(
            "Product Load",
            style: TextStyle(fontSize: 32),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: FutureBuilder<http.Response>(
              future: UtilHttp.productGet(),
              builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done
                  ? const Text("loading")
                  : Text(const JsonEncoder.withIndent("  ").convert(jsonDecode(snapshot.data!.body))),
            ),
          )
        ],
      ),
    );
  }
}

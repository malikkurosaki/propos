import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: const BackButton(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Transaction",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ]),
            Flexible(
                child: Row(
              children: [
                Container(
                  color: Colors.blueGrey[50],
                  alignment: Alignment.topLeft,
                  width: 300,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Search",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                            fillColor: Colors.white,
                            filled: true
                          ),
                        ),
                      ),
                      for (final item in UtilValue.listBill)
                        ListTile(
                          leading: const Icon(Icons.payment),
                          title: Text(item['id_bill']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['payment_date'].toString()),
                              Text(item['payment_value'].toString())
                            ],
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.keyboard_arrow_right),
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final item in UtilValue.listBill)
                        ListTile(
                          
                          title: Text(item['id_bill']),
                          subtitle: Text(item['payment_date'].toString()),
                        )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

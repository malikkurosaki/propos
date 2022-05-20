import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/util_pref.dart';

class CashierPagePaymentFinish extends StatelessWidget {
  final String? paymentValue;
  final int? change;
  final int? haveToPay;
  const CashierPagePaymentFinish({this.paymentValue, this.change, this.haveToPay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(16),
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                      child: Text(
                    "Success",
                    style: TextStyle(fontSize: 53, fontWeight: FontWeight.bold, color: Colors.green),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transaction ID : ${UtilPref.billId.value}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Divider(),
                      Text(
                        "Payment : ${paymentValue}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Divider(),
                      Text(
                        "Have to pay : $haveToPay",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                change == 0
                    ? SizedBox.shrink()
                    : Card(
                        margin: EdgeInsets.only(top: 50),
                        color: Colors.brown[50],
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Change : ",
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                Center(
                                  child: Text(
                                    "${change}",
                                    style: TextStyle(fontSize: 53, fontWeight: FontWeight.bold, color: Colors.cyan),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.cyan[200],
                          radius: 50,
                          child: Icon(
                            Icons.print,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.red[200],
                          radius: 50,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green[200],
                          radius: 50,
                          child: Icon(
                            Icons.whatsapp,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  color: Colors.green,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    UtilRoutes.cashier().goOffAll();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

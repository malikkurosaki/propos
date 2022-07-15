import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/util_value.dart';

class CashierPagePaymentFinish extends StatelessWidget {
  // final String? paymentValue;
  // final int? change;
  // final int? haveToPay;
  const CashierPagePaymentFinish({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24),
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
                        "Transaction ID : ${GVal.transactionId.value.val}",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      Text(
                        "Payment : "+ NumberFormat.currency(locale: 'id_ID', symbol: "", decimalDigits: 0).format(int.parse(GVal.payValue.value.val.toString())),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const Divider(),
                      Text(
                        "Have to pay : "+ NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(GVal.haveToPay.value.val),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GVal.changeValue.value.val == 0
                    ? const SizedBox.shrink()
                    : Card(
                        margin: const EdgeInsets.only(top: 50),
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
                                    NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(GVal.changeValue.value.val),
                                    style: const TextStyle(fontSize: 53, fontWeight: FontWeight.bold, color: Colors.cyan),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.cyan[200],
                          radius: 50,
                          child: const Icon(
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
                          child: const Icon(
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
                          child: const Icon(
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
                    padding: const EdgeInsets.all(16),
                    child: const Center(
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

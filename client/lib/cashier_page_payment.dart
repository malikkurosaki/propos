import 'package:client/util_routers.dart';
import 'package:fluid_kit/fluid_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'util_pref.dart';

final listHotKey = [
  "Pass",
  "5000",
  "10000",
  "20000",
  "50000",
  "100000",
  "200000",
  "500000",
  "1000000",
];

class CashierPagePayment extends StatelessWidget {
  CashierPagePayment({Key? key}) : super(key: key);
  final paymentValue = "0".obs;
  final paymentMethod = "cash".obs;
  final isOk = false.obs;

  int haveToPay() => UtilPref.listorder
      .fold(
        0,
        (previousValue, element) =>
            int.parse(previousValue!.toString()) +
            (int.parse(
                  element['price'].toString().replaceAll(".", ""),
                ) *
                element['qty']),
      )
      .toInt();

  bool checkIsok() => isOk.value = int.parse(paymentValue.value) >= haveToPay() && paymentValue.value.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) => Obx(
            () => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      BackButton(
                        onPressed: () => UtilRoutes.cashier().go(),
                      ),
                      Expanded(
                        child: Text(
                          "Payment",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 720),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Transaction ID",
                                            style:
                                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                                          ),
                                          Text(
                                            UtilPref.billId.value.toString(),
                                            style:
                                                TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown[100]),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Have to pay",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                                      ),
                                      // total order
                                      Text(
                                        NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0).format(
                                          haveToPay(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: MaterialButton(
                                    color: Colors.purple,
                                    onPressed: !isOk.value ? null : () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                                      child: Center(
                                        child: Text(
                                          "Pay",
                                          style:
                                              TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.green[100],
                                backgroundColor: Colors.green[100],
                                title: Text("Hot Key",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                                children: [
                                  Wrap(
                                    children: [
                                      for (final h in listHotKey)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: MaterialButton(
                                            color: Colors.green,
                                            onPressed: () {
                                              if (h == "Pass") {
                                                paymentValue.value = haveToPay().toString();
                                              } else {
                                                paymentValue.value = h;
                                              }
            
                                              checkIsok();
                                            },
                                            child: Container(
                                              width: 120,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    h == "Pass"
                                                        ? "Pass"
                                                        : NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0)
                                                            .format(int.parse(h.toString()))
                                                            .toString()
                                                            .replaceAll("Rp", ""),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Wrap(
                              children: [
                                Card(
                                  color: Colors.brown[100],
                                  child: SizedBox(
                                    width: sizingInformation.isMobile ? 500 : 350,
                                    child: ExpansionTile(
                                      iconColor: Colors.brown,
                                      initiallyExpanded: !sizingInformation.isMobile,
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          paymentMethod.value.toString(),
                                          style:
                                              TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          color: Colors.brown[50],
                                          child: SizedBox(
                                            width: sizingInformation.isMobile ? 500 : 350,
                                            height: Get.height * 0.4,
                                            child: GridButton(
                                              borderColor: Colors.brown[100],
                                              hideSurroundingBorder: true,
                                              onPressed: (value) {
                                                paymentMethod.value = value;
                                              },
                                              items: [
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Cash",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "cash",
                                                  ),
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Debit",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "debit",
                                                  ),
                                                ],
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Credit",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "credit",
                                                  ),
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Voucher",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "voucher",
                                                  ),
                                                ],
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Gift Card",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "giftcard",
                                                  ),
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Transfer",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "transfer",
                                                  ),
                                                ],
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Paypal",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "paypal",
                                                  ),
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Alipay",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "alipay",
                                                  ),
                                                ],
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Wechat",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "wechat",
                                                  ),
                                                  GridButtonItem(
                                                    child: Text(
                                                      "QR Code",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "qrcode",
                                                  ),
                                                ],
                                                [
                                                  GridButtonItem(
                                                    child: Text(
                                                      "Others",
                                                      style: TextStyle(
                                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                                                    ),
                                                    value: "others",
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.49,
                                  width: sizingInformation.isMobile ? 500 : 350,
                                  child: Card(
                                    color: Colors.brown[50],
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.brown[100],
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            NumberFormat.currency(locale: "id_ID", symbol: "")
                                                .format(int.parse(paymentValue.value.isEmpty ? "0" : paymentValue.value))
                                                .replaceAll(",00", ""),
                                            style:
                                                TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.brown),
                                          ),
                                        ),
                                        Flexible(
                                          child: GridButton(
                                            hideSurroundingBorder: true,
                                            borderColor: Colors.brown[100],
                                            textStyle: TextStyle(color: Colors.brown),
                                            items: [
                                              [
                                                GridButtonItem(
                                                  value: "1",
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "2",
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "3",
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                              ],
                                              [
                                                GridButtonItem(
                                                  value: "4",
                                                  child: Text(
                                                    "4",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "5",
                                                  child: Text(
                                                    "5",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "6",
                                                  child: Text(
                                                    "6",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                              ],
                                              [
                                                GridButtonItem(
                                                  value: "7",
                                                  child: Text(
                                                    "7",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "8",
                                                  child: Text(
                                                    "8",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "9",
                                                  child: Text(
                                                    "9",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                              ],
                                              [
                                                GridButtonItem(
                                                  value: "0",
                                                  child: Text(
                                                    "0",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "del",
                                                  child: Text(
                                                    "c",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                                GridButtonItem(
                                                  value: "00",
                                                  child: Text(
                                                    "00",
                                                    style: TextStyle(fontSize: 40),
                                                  ),
                                                ),
                                              ],
                                            ],
                                            onPressed: (apa) {
                                              if (apa == "0") {
                                                paymentValue.value = apa;
                                              } else if (apa.toString() == "del") {
                                                if (int.parse(paymentValue.value) > 0) {
                                                  paymentValue.value =
                                                      paymentValue.value.substring(0, paymentValue.value.length - 1);
                                                }
                                              } else if (apa == "00") {
                                                paymentValue.value = paymentValue.value + "00";
                                              } else {
                                                paymentValue.value = paymentValue.value + apa;
                                              }
            
                                              checkIsok();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

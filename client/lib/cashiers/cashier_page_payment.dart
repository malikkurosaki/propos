import 'package:client/cashiers/cashier_page_payment_finish.dart';
import 'package:client/comps/comp_calculator.dart';
import 'package:client/utils/util_routers.dart';
import 'package:fluid_kit/fluid_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';
import '../utils/util_pref.dart';
import 'package:animate_do/animate_do.dart' as anido;

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

  int haveToPay() {
    int htp = UtilPref.listorder
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
    return htp;
  }

  bool checkIsok() {
    isOk.value = int.parse(paymentValue.value) >= haveToPay() && paymentValue.value.isNotEmpty;
    return isOk.value;
  }

  onload() {
    if (UtilPref.billId.value.isEmpty) {
      UtilPref.billIdSet(value: const Uuid().v4());
    }
  }

  @override
  Widget build(BuildContext context) {
    onload();
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
                      CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: BackButton(
                          color: Colors.grey,
                          onPressed: () => UtilRoutes.cashier().go(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Payment",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.cyan),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        
                                        children: [
                                          const Text(
                                            "Transaction ID",
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (UtilPref.billId.value.toString().split("-")[0].toString()),
                                              style: TextStyle(
                                                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown[100]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Have to pay",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan),
                                      ),
                                      // total order
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0).format(
                                            haveToPay(),
                                          ),
                                          style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: isOk.value,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: MaterialButton(
                                        color: Colors.purple,
                                        onPressed: () {
                                          final dataBill = {
                                            "id_bill": UtilPref.billId.value,
                                            "id_user": "UtilPref.id.value",
                                            "id_store": "UtilPref.idStore.value",
                                            "id_payment": "paymentMethod.value,",
                                            "payment_value": paymentValue.value,
                                            "payment_date": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
                                            "payment_status": "paid",
                                            "payment_type": "cash",
                                            "payment_method": "cash",
                                            "value_change": "0",
                                            "pax": UtilPref.pax.value,
                                            "customer": Map.from(UtilPref.customer),
                                            "bill": List.from(UtilPref.listorder),
                                          };

                                          UtilPref.listBill.add(dataBill);
                                          UtilPref.listBillSet();

                                          UtilPref.paxSet(value: 1);
                                          UtilPref.customerSet(value: {});
                                          UtilPref.listorderSet(value: []);
                                          UtilPref.savedOrderSet(value: {});

                                          int change = 0;
                                          if (haveToPay() < int.parse(paymentValue.value)) {
                                            change = int.parse(paymentValue.value) - haveToPay();
                                          }

                                          Get.to(CashierPagePaymentFinish(
                                              paymentValue: paymentValue.value,
                                              change: change,
                                              haveToPay: haveToPay()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                                          child: const Center(
                                            child: Text(
                                              "Pay",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: anido.ElasticInDown(
                              child: ExpansionTile(
                                collapsedBackgroundColor: Colors.grey[100],
                                backgroundColor: Colors.grey[300],
                                title: Text("Hot Key",
                                    style:
                                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                children: [
                                  Wrap(
                                    children: [
                                      for (final h in listHotKey)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: MaterialButton(
                                            color: Colors.grey[700],
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
                                                    style: const TextStyle(
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
                                anido.ElasticInLeft(
                                  child: Card(
                                    color: Colors.brown[100],
                                    child: SizedBox(
                                      width: sizingInformation.isMobile ? 500 : 350,
                                      child: ExpansionTile(
                                        iconColor: Colors.brown,
                                        initiallyExpanded: !sizingInformation.isMobile,
                                        title: Text(
                                          paymentMethod.value.toString(),
                                          style: const TextStyle(
                                              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.brown),
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
                                                items: const [
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Cash",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "cash",
                                                    ),
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Debit",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "debit",
                                                    ),
                                                  ],
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Credit",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "credit",
                                                    ),
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Voucher",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "voucher",
                                                    ),
                                                  ],
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Gift Card",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "giftcard",
                                                    ),
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Transfer",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "transfer",
                                                    ),
                                                  ],
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Paypal",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "paypal",
                                                    ),
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Alipay",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "alipay",
                                                    ),
                                                  ],
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Wechat",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "wechat",
                                                    ),
                                                    GridButtonItem(
                                                      child: Text(
                                                        "QR Code",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
                                                      ),
                                                      value: "qrcode",
                                                    ),
                                                  ],
                                                  [
                                                    GridButtonItem(
                                                      child: Text(
                                                        "Others",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.brown),
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
                                ),
                                SizedBox(
                                  height: Get.height * 0.49,
                                  width: sizingInformation.isMobile ? 500 : 350,
                                  child: CompCalculator(onChange: (p0) {
                                    paymentValue.value = p0;
                                    checkIsok();
                                  }),
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

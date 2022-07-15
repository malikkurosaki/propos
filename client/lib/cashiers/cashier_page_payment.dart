import 'dart:convert';

import 'package:client/cashiers/cashier_page_payment_finish.dart';
import 'package:client/comps/comp_app_bar.dart';
import 'package:client/comps/comp_calculator.dart';
import 'package:client/comps/comp_detail_print.dart';
import 'package:client/comps/comp_payment_method.dart';
import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:uuid/uuid.dart';

import '../utils/util_value.dart';
// import 'package:animate_do/animate_do.dart' as anido;

final listHotKey = [
  "Pass",
  "1000",
  "5000",
  "10000",
  "15000",
  "20000",
  "25000",
  "50000",
  "55000",
  "100000",
  "150000",
  "200000",
  "250000",
  "500000",
  "550000",
  "1000000",
];

final listPaymentMethod = [
  "Cash",
  "Debit",
  "Credit",
  "Gopay",
  "Dana",
  "OVO",
  "T-cash",
  "Indomaret",
  "Kioson",
  "Lainnya",
];

class CashierPagePayment extends StatelessWidget {
  CashierPagePayment({Key? key}) : super(key: key);
  // final paymentValue = "0".obs;
  // final paymentMethod = "cash".obs;
  final isOk = false.obs;

  bool _checkIsok() {
    isOk.value = int.parse(GVal.payValue.value.val) >= GVal.haveToPay.value.val && GVal.payValue.value.val.isNotEmpty;
    if (isOk.value) {
     // change
     GVal.changeValue.value.val = int.parse(GVal.payValue.value.val) - GVal.haveToPay.value.val;
     GVal.changeValue.refresh();
    }else{
      GVal.changeValue.value.val = 0;
      GVal.changeValue.refresh();
    }
    return isOk.value;
  }

  final lebarTitle = 150.0;

  _onload() async {
    UtilLoad.loadPaymentMethod();
    if (GVal.transactionId.value.val.isEmpty) {
      GVal.transactionId.value.val = const Uuid().v4();
      GVal.transactionId.refresh();
    }
    // if (UtilValue.billId.value.isEmpty) {
    //   UtilValue.billIdSet(value: const Uuid().v4());
    // }

    _haveToPay();
    _checkIsok();
  }

  _haveToPay() {
    GVal.haveToPay.value.val = GVal.listOrders.value.val
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
    GVal.haveToPay.refresh();
  }

  @override
  Widget build(BuildContext context) {
    _onload();
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompAppBar(
                title: "Payment",
                onBack: () => UtilRoutes.cashier().go(),
                surfix: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => Visibility(
                      visible: isOk.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: ()async {
                            
                            final totalQty = GVal.listOrders.value.val
                                .map((element) => int.parse(element['qty'].toString()))
                                .reduce((value, element) => value + element);
                            final totalPrice = GVal.listOrders.value.val
                                .map((element) =>
                                    int.parse(element['price'].toString()) * int.parse(element['qty'].toString()))
                                .reduce((value, element) => value + element);

                            final id = const Uuid().v4();
                            final bodyListBill = {
                              "id": id,
                              "usersId": GVal.user.value.val['id'],
                              "transactionId": GVal.transactionId.value.val,
                              "totalQty": totalQty,
                              "totalItems": GVal.listOrders.value.val.length,
                              "totalPrice": totalPrice,
                              "billTypesId": GVal.billType.value.val['id'],
                              "pax": GVal.pax.value.val,
                              "customersId": GVal.customer.value.val['id'],
                              "paymentMethodsId": GVal.paymentMethod.value.val['id'],
                              "outletsId": GVal.outlet.value.val['id'],
                              "employeesId": GVal.employee.value.val['id'],
                            };

                            
                            final bodyBilles = [];
                            for (final item in GVal.listOrders.value.val) {
                              final body = {};
                              body['transactionId'] = GVal.transactionId.value.val;
                              body['listBillId'] = id;
                              body['productsId'] = item['id'];
                              body['qty'] = item['qty'];
                              body['totalPrice'] = item['price'] * item['qty'];
                              body['note'] = item['note'].toString().isEmpty? null: item['note'];
                              body['discountsId'] = item['discountsId'];
                              body['taxesId'] = item['taxesId'];
                              body['categoriesId'] = item['categoriesId'];

                              bodyBilles.add(body);
                            }

                           final data = {
                              "bodyListBill": jsonEncode(bodyListBill),
                              "bodyBilles": jsonEncode(bodyBilles)
                            };

                            
                            final res = await UtilHttp.listbillBill(data);
                            
                            if(res.statusCode == 200){
                              GVal.listOrders.value.val = [];
                              GVal.listOrders.refresh();
                              GVal.billType.value.val = {};
                              GVal.billType.refresh();
                              GVal.pax.value.val = 1;
                              GVal.pax.refresh();
                              GVal.customer.value.val = {};
                              GVal.customer.refresh();
                              GVal.paymentMethod.value.val = {};
                              GVal.paymentMethod.refresh();
                              GVal.employee.value.val = {};
                              GVal.employee.refresh();
                              GVal.transactionId.value.val = const Uuid().v4();
                              GVal.transactionId.refresh();
                              
                              UtilRoutes.paymentFinish().goOff();
                            }else{
                              // GVal.payValue.value.val = "0";
                              // GVal.payValue.refresh();
                              // GVal.haveToPay.value.val = 0;
                              // GVal.haveToPay.refresh();
                              // GVal.changeValue.value.val = 0;
                              // GVal.changeValue.refresh();

                              EasyLoading.showError(res.statusCode.toString());
                            }
                           
                          },
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(
                                  Icons.double_arrow_sharp,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Pay Now",
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: sizingInformation.isDesktop,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), color: Colors.white),
                        width: 340,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: CompDetailPrint(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        controller: ScrollController(),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Visibility(
                                          visible: !sizingInformation.isMobile,
                                          child: Container(
                                            width: lebarTitle,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Transaction ID",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 8),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: Colors.grey.shade300),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  (GVal.transactionId.value.val.toString().substring(0, 8)),
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  (GVal.transactionId.value.val.toString().substring(8)),
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[100]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Visibility(
                                          visible: !sizingInformation.isMobile,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            width: lebarTitle,
                                            child: Text(
                                              "Have to pay",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // total order
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.only(bottom: 8),
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.grey.shade300,
                                                      )),
                                                  child: Text(
                                                    NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0)
                                                        .format(
                                                      GVal.haveToPay.value.val,
                                                    ).replaceAll("Rp",""),
                                                    style: TextStyle(
                                                      fontSize: 36,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Obx(
                                                () => Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.grey.shade300,
                                                    ),
                                              
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text( "Change "),
                                                      Text(
                                                        NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0)
                                                            .format(
                                                          GVal.changeValue.value.val,
                                                        ).replaceAll("Rp", ""),
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.grey[700],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // payment method
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: !sizingInformation.isMobile,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            width: lebarTitle,
                                            child: Text(
                                              "Payment method",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // dropdown payment method
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CompPaymentMethod(
                                                value: Map.from(GVal.paymentMethod.value.val),
                                                values: List.from(GVal.paymentMethods.value.val),
                                                onPaymentMethodChanged: (value) {
                                                  GVal.paymentMethod.value.val = value;
                                                  GVal.paymentMethod.refresh();
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: CircleAvatar(
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Get.dialog(AlertDialog(
                                                              scrollable: true,
                                                              title: const Text("Hot Key"),
                                                              content: Column(
                                                                children: [
                                                                  for (final hk in listHotKey)
                                                                    Visibility(
                                                                      visible: hk == "Pass" ||
                                                                          int.parse(hk) >
                                                                              int.parse(
                                                                                  GVal.haveToPay.value.val.toString()),
                                                                      child: ListTile(
                                                                        leading: const Icon(
                                                                            Icons.local_fire_department_outlined),
                                                                        title: Text(
                                                                          hk.toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        trailing: const Icon(
                                                                            Icons.arrow_forward_ios_outlined),
                                                                        onTap: () {
                                                                          if (hk == "Pass") {
                                                                            GVal.payValue.value.val =
                                                                                GVal.haveToPay.value.val.toString();
                                                                            GVal.payValue.refresh();
                                                                            Get.back();
                                                                          } else {
                                                                            GVal.payValue.value.val = hk;
                                                                            GVal.payValue.refresh();
                                                                            Get.back();
                                                                          }
                                                                          _checkIsok();
                                                                        },
                                                                      ),
                                                                    )
                                                                ],
                                                              ),
                                                            ));
                                                          },
                                                          icon: const Icon(Icons.handshake_outlined)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 70,
                                                      margin: const EdgeInsets.only(bottom: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(color: Colors.grey.shade300),
                                                      ),
                                                      child: Center(
                                                        child: Obx(
                                                          () => ListTile(
                                                            title: Text(
                                                              NumberFormat.simpleCurrency(
                                                                      locale: "id_ID", decimalDigits: 0)
                                                                  .format(
                                                                int.parse(GVal.payValue.value.val.toString().isEmpty
                                                                    ? "0"
                                                                    : GVal.payValue.value.val.toString()),
                                                              ).replaceAll("Rp", ""),
                                                              style: TextStyle(
                                                                  fontSize: 32,
                                                                  color: Colors.grey[600],
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: CircleAvatar(
                                                      child: IconButton(
                                                          onPressed: () {
                                                            GVal.payValue.value.val = "0";
                                                            GVal.payValue.refresh();
                                                            _checkIsok();
                                                          },
                                                          icon: const Icon(Icons.clear_rounded)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration:
                                                    BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                                                height: Get.height / 2,
                                                child: Obx(
                                                  (() => CompCalculator(
                                                      defaultValue: GVal.payValue.value.val,
                                                      onChange: (p0) {
                                                        GVal.payValue.value.val = p0;
                                                        GVal.payValue.refresh();
                                                        _checkIsok();
                                                      },
                                                      valueBar: false)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

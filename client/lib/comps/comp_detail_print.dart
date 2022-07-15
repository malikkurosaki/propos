import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CompDetailPrint extends StatelessWidget {
  CompDetailPrint({Key? key}) : super(key: key);
  final pax = 1.obs;

  _onload() {}

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [
            // outlet name
            Text(
              GVal.outlet.value.val['name'].toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey[700]),
            ),
            // outlet address
            Text(
              GVal.outlet.value.val['address'].toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
            ),
            // outlet phone
            Text(
              GVal.outlet.value.val['phone'].toString().toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
            ),

            Row(
              children: [
                // date
                Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                ),
                const Text(" | "),
                // time
                Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Pax: "),
                Text(
                  GVal.pax.value.val.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Customer: "),
                Text(
                  GVal.customer.value.val['name'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            const Divider(),
            for (final dtl in GVal.listOrders.value.val)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dtl['name'].toString(),
                            style: TextStyle(color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // sub total
                        Text(
                          NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0, name: "")
                              .format(
                                (int.parse(dtl['qty'].toString()) *
                                    int.parse(
                                      dtl['price'].toString(),
                                    )),
                              )
                              .toString(),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(dtl['qty'].toString()),
                        const Text("x"),
                        Text(NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "")
                            .format((dtl['price'] ?? 0))
                            .toString()),
                      ],
                    )
                  ],
                ),
              ),
            const Divider(),
            const Text("Total Qty: "),
            const Divider(),
            // total
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(
                      NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "").format(
                        GVal.listOrders.value.val.fold(
                          0,
                          (total, item) =>
                              int.parse(total!.toString()) +
                              (int.parse(item['qty'].toString()) *
                                  int.parse(
                                    item['price'].toString(),
                                  )),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Discount"),
                    Text(
                      (GVal.savedOrder.value.val['discount'] ?? "-").toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(
                      (GVal.savedOrder.value.val['total'] ?? "-").toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

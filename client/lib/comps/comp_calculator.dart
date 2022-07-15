import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompCalculator extends StatelessWidget {
  CompCalculator({Key? key, this.defaultValue = "", required this.onChange, this.valueBar = true}) : super(key: key);
  final String defaultValue;
  final paymentValue = "0".obs;
  final Function(String) onChange;
  final bool valueBar;

  _onLoad() {
    
    if (defaultValue.isNotEmpty) {
      paymentValue.value = defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.brown,
                width: 0.5,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: Obx(
            () => Visibility(
              visible: valueBar,
              child: Text(
                NumberFormat.currency(locale: "id_ID", symbol: "")
                    .format(int.parse(paymentValue.value.isEmpty ? "0" : paymentValue.value))
                    .replaceAll(",00", ""),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
            ),
          ),
        ),
        Flexible(
          child: GridButton(
            hideSurroundingBorder: true,
            borderColor: Colors.brown[100],
            textStyle: const TextStyle(color: Colors.brown),
            items: const [
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
                if (paymentValue.value.isEmpty || paymentValue.value == "0") {
                  paymentValue.value = "0";
                } else {
                  paymentValue(paymentValue.value + "0");
                }
              } else if (apa == "del") {
                if (paymentValue.value.length > 1) {
                  paymentValue(paymentValue.value.substring(0, paymentValue.value.length - 1));
                }else{
                  paymentValue("0");
                }
              } else if (apa == "00") {
                paymentValue(paymentValue.value + "00");
              } else {
                if(paymentValue.value == "0"){
                  paymentValue.value = apa;
                }else{
                  paymentValue.value += apa;
                }
                
              }

              onChange(paymentValue.value);
            },
          ),
        ),
      ],
    );
  }
}

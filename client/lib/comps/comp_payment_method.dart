import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CompPaymentMethod extends StatelessWidget {
  CompPaymentMethod({Key? key, this.onPaymentMethodChanged, this.value = const {}, this.values = const []})
      : super(key: key);

  final Function(Map paymentMethod)? onPaymentMethodChanged;
  final paymentMethod = {}.obs;
  final Map<String, dynamic> value;
  final List<Map<String, dynamic>> values;
  final ket = "keterangan".obs;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: values.isEmpty || value.isEmpty
          ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300
              )
            ),
              padding: EdgeInsets.all(8),
              child: Text("Payment Method is empty , create it one on setting"),
            )
          : DropdownButtonFormField<Map>(
              isDense: true,
              value: values[values.indexWhere((element) => element['id'] == value['id'])],
              decoration: const InputDecoration(
                // labelText: "Payment Method",
                hintText: "Pyament Method",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              items: [
                for (final cat in values)
                  DropdownMenuItem(
                    value: cat,
                    child: Text(
                      cat['name'].toString().toUpperCase(),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      
                    ),
                  )
              ],
              onChanged: (value) {
                debugPrint(value.toString());
                onPaymentMethodChanged!(value!);
                // paymentMethod.value = value;
              },
            ),
    );
  }
}

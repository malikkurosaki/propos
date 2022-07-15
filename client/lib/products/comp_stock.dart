import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class CompStock extends StatelessWidget {
  CompStock({Key? key, this.onMinStockChange, this.onStockChange}) : super(key: key);
  final stock = false.obs;
  final _stockController = TextEditingController();
  final _minStockController = TextEditingController();

  final Function(String stock)? onStockChange;
  final Function(String minStock)? onMinStockChange;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Obx(
        () => SizedBox(
          width: sizingInformation.isMobile ? double.infinity : 360,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text(
                    "Stock",
                    style: TextStyle(fontSize: 32),
                  ),
                  value: stock.value,
                  onChanged: (value) => stock.value = !stock.value,
                ),
                Visibility(
                  visible: stock.value,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _stockController,
                          onChanged: (value) {
                            if(value.isNum){
                              onStockChange!(value);
                            }else{
                              _stockController.text = "";
                              EasyLoading.showError("Stock must be number");
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Stock",
                              hintText: "Stock",
                              fillColor: Colors.grey[100],
                              filled: true,
                              border: const OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      // min stock
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _minStockController,
                          onChanged: (value) {
                            if(value.isNum){
                              onMinStockChange!(value);

                              if(int.parse(_minStockController.text) > int.parse(_stockController.text)){
                                EasyLoading.showError("Min stock must be less than stock");
                                _minStockController.text = "";
                              }
                              
                            }else{
                              _minStockController.text = '';
                              EasyLoading.showError("Min Stock must be number");
                            }



                          },
                          decoration: InputDecoration(
                              labelText: "Min Stock",
                              hintText: "Min Stock",
                              fillColor: Colors.grey[100],
                              filled: true,
                              border: const OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                    ],
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

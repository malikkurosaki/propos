import 'package:client/products/comp_select_category.dart';
import 'package:client/products/comp_select_outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

import '../utils/util_value.dart';
import '../utils/util_routers.dart';

class CompFormCreateProduct extends StatelessWidget {
  CompFormCreateProduct({Key? key, this.onCategoryChange, this.onDescriptionChange, this.onNameChange, this.onOutletChange, this.onPriceChange}) : super(key: key);
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  final Function(String name)? onNameChange;
  final Function(String price)? onPriceChange;
  final Function(String description)? onDescriptionChange;
  final Function(Map category)? onCategoryChange;
  final Function(Map outlet)? onOutletChange;

  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SizedBox(
        width: sizingInformation.isMobile ? double.infinity : 360,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300
            )
          ),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "form create product",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              // name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  onChanged: (value) => onNameChange!(value),
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Product Name",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              // price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: _priceController,
                  onChanged: (value) {
                    if (!value.isNum) {
                      EasyLoading.showError('Price must be number');
                      _priceController.text = '';
                      return;
                    }

                    onPriceChange!(value);
                  },
                  decoration: const InputDecoration(
                    labelText: "Price",
                    hintText: "Product Price",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              // description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _descriptionController,
                  onChanged: (value) => onDescriptionChange!(value),
                  decoration: const InputDecoration(
                    labelText: "Description",
                    hintText: "Product Description",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              // dropdown choose outlet by name
              CompSelectOutlet(onSelect: (value) => onOutletChange!(value)),
              // dropdown choose category by name
              CompSelectCategory(onSelect: (value) => onCategoryChange!(value)),

              // image picker button
            ],
          ),
        ),
      ),
    );
  }
}

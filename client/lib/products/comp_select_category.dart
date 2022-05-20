import 'package:client/utils/util_pref.dart';
import 'package:flutter/material.dart';

import '../utils/util_routers.dart';

class CompSelectCategory extends StatelessWidget {
  const CompSelectCategory({Key? key, required this.onSelect}) : super(key: key);
  final Function(Map) onSelect;
  @override
  Widget build(BuildContext context) {
    return UtilPref.categories.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () => UtilRoutes.categoryPage().go(),
                child: Text(
                  'Category Is Empty , Create One?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        :  Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Map>(
        decoration: InputDecoration(
            labelText: "Category",
            hintText: "Choose Category",
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        items: [
          for (final cat in UtilPref.categories)
            DropdownMenuItem(
              value: cat,
              child: Text(
                cat['name'].toString(),
              ),
            )
        ],
        onChanged: (value) {
          onSelect(value!);
        },
      ),
    );
  }
}

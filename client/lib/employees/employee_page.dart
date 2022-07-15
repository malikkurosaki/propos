import 'package:client/comps/comp_app_bar.dart';
import 'package:client/employees/employee_create.dart';
import 'package:client/utils/util_load.dart';
import 'package:client/utils/util_routers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'employee_list.dart';

class EmployeePage extends StatelessWidget {
  EmployeePage({Key? key}) : super(key: key);
  final element = "1".val('employeeElement').obs;

  final listStack = [
    {
      "id": "1",
      "name": "Employee List",
      "element": EmployeeList(),
    },
    {
      "id": "2",
      "name": "Employee Create",
      "element": EmployeeCreate(),
    }
  ];

  _onload(){
    UtilLoad.loadEmployee();
  }

  @override
  Widget build(BuildContext context) {
    _onload();

    return Material(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CompAppBar(title: "employee", onBack: () => UtilRoutes.home().go()),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: !sizingInformation.isMobile,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: Colors.grey.shade300)),
                        ),
                        width: 320,
                        child: Obx(
                          () => ListView(
                            children: [
                              for (final item in listStack)
                                ListTile(
                                  onTap: () {
                                    element.value.val = item['id'].toString();
                                    element.refresh();
                                  },
                                  selected: element.value.val == item['id'].toString(),
                                  title: Text(item['name'].toString()),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Obx(
                          () => Stack(
                            alignment: Alignment.topLeft,
                            fit: StackFit.loose,
                            children: [
                              for (final item in listStack)
                                Visibility(
                                  visible: element.value.val == item['id'].toString(),
                                  child: item['element'] as Widget,
                                )
                            ],
                          ),
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
    );
  }
}

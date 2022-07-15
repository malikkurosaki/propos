import 'package:client/utils/g_val.dart';
import 'package:client/utils/util_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

// EmployeeList
// id
// pin
// name
// address
// phone
// email
// password
// createdAt
// updatedAt
// User
// usersId
// ListBill
// Roles
// outletsId
// rolesId
// Outlets

class EmployeeList extends StatelessWidget {
  EmployeeList({Key? key}) : super(key: key);
  final _lisTEmployee = [...GVal.employees.value.val].obs;
  final _searchController = TextEditingController();

  // _onLoading() {
  //  _syncListEmployee();
  // }

  _syncListEmployee(){
    if (GVal.employees.value.val.isNotEmpty) {
      _lisTEmployee.assignAll(GVal.employees.value.val);
    }
  }

  @override
  Widget build(BuildContext context) {
 

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => SizedBox(
        width: sizingInformation.isMobile ? double.infinity : 460,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      final data = GVal.employees.value.val.where((element) => element['name'].toString().contains(value.toString())).toList();
                      _lisTEmployee.assignAll(data);

                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _searchController.clear();
                    _syncListEmployee();
                  },
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView(
                  controller: ScrollController(),
                  children: [
                    for(final emp in _lisTEmployee)
                    ExpansionTile(
                      title: Text(emp['name']),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text("Pin: "),
                              Text(emp['pin']),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Password: "),
                              Text(emp['password'])
                            ],
                          )
                        ],
                      ),
                      children: [
                        ListTile(
                          title: Text("Edit"),
                          trailing: Icon(Icons.edit),
                        ),
                        ListTile(
                          title: Text("Delete"),
                          trailing: Icon(Icons.delete),
                        ),
                        ListTile(
                          title: Text("Share"),
                          trailing: Icon(Icons.share),
                        )
                      ],
                    )
                  ],
                )
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

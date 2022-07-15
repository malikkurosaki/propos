import 'package:client/utils/util_http.dart';
import 'package:client/utils/util_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmployeeCreate extends StatelessWidget {
  EmployeeCreate({Key? key}) : super(key: key);

  final formController = <String, TextEditingController>{
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "address": TextEditingController(),
    "phone": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) =>
      Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300
              )
            ),
            width: sizingInformation.isMobile? double.infinity: 360,
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Create New Emploee",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade600
                    ),
                  ),
                ),
                for (final key in formController.keys)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: formController[key],
                      decoration: InputDecoration(
                        labelText: key,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: ()async{

                      // id
                      // name
                      // address
                      // phone
                      // email
                      // password
                      // createdAt
                      // updatedAt
                      // Roles
                      // rolesId
                      // User
                      // usersId
                      // ListBill

                      
                      final body = {
                        "name": formController['name']!.text,
                        "email": formController['email']!.text,
                        "password": formController['password']!.text,
                        "address": formController['address']!.text,
                        "phone": formController['phone']!.text,
                      };

                      if(body.values.contains("")){
                        EasyLoading.showError("Please fill all the fields");
                        return;
                      }

                      final res = await UtilHttp.employeeCreate(body);
                      if(res.statusCode == 200){
                        EasyLoading.showSuccess("Employee Created");
                        UtilLoad.loadEmployee(isAler: true);
                      }else{
                        EasyLoading.showError(res.body);
                      }


                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: Text("Save",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

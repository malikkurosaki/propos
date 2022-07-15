import 'package:client/utils/util_http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginByPin extends StatelessWidget {
  LoginByPin({Key? key}) : super(key: key);
  final _pinController = TextEditingController();
  final _employee = "".obs;
  final _hidePin = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Login As Employee',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _pinController,
                          obscureText: _hidePin.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            _employee.value = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "PIN",
                            hintText: "Pin",
                            fillColor: Colors.grey[50],
                            prefixIcon: const Icon(Icons.pending_sharp),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hidePin.value ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _hidePin.value = !_hidePin.value;
                                _employee.refresh();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        MaterialButton(
                          color: Colors.teal,
                          onPressed: () async{
                            final res = await UtilHttp.employeeLoginPin({
                              "pin": _pinController.text,

                            });

                            debugPrint(res.body);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: const Center(
                              child: Text(
                                'Masuk',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        "assets/images/emp.png",
                        fit: BoxFit.scaleDown,
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

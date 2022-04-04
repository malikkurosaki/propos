import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

final listMenu = [
  {
    "title": "Home",
    "goTo": "/home",
  },
  {
    "title": "Cashier",
    "goTo": "/cashier",
  },
  {
    "title": "History",
    "goTo": "/history",
  },
  {
    "title": "Profile",
    "goTo": "/profile",
  },
  {
    "title": "Logout",
    "goTo": "/logout",
  },
];

class PageHome extends StatelessWidget {
  const PageHome({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("app Bar")
              ],
            ),
            Flexible(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 720,
                  ),
                  child: Container(
                    color: Colors.grey[100],
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          for (var item in listMenu)
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: InkWell(
                                onTap: () => Get.toNamed(item["goTo"].toString()),
                                child: Card(
                                  child: ListTile(
                                    title: Text(item["title"].toString()),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            )
          ],
        )
      )
      ,
    );
  }
}
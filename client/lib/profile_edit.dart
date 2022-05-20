import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ResponsiveBuilder(
        builder: (context, sizingInformation) => SafeArea(
          child: Column(
            children: [
              Text("ini adalah"),
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 720,
                      height: double.infinity,
                      color: Colors.blueGrey[50],
                      child: Text("ini dimana"),
                    ),
                  ],
                ),
              ),
              Container(
                width: 500,
                color: Colors.blueGrey[50],
                child: Text("ini dimana"),

              )
            ],
          ),
        ),
      ),
    );
  }
}

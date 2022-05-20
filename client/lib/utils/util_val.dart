import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UtilVal{
  static final listOrderController = ScrollController();
  static final isMobile = false.obs;
  static final logo = const AssetImage('assets/images/bg2.jpg').obs;
  static final devMode = true.obs;
}
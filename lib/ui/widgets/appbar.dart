import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar myappbar({
  Widget? leading,
  List<Widget>? actions,
  bool centerTitle = false,
  Widget? title,
  required BuildContext context,
}) =>
    AppBar(
      leading: leading,
      actions: actions,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      foregroundColor: context.theme.primaryColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: title,
    );

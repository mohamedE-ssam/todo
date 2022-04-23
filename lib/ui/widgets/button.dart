import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.ontap,
      this.width = 100,
      required this.text,
      this.height = 50,
      this.color = primaryClr})
      : super(key: key);
  final Function() ontap;
  final double width;
  final double height;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          height: height,
          width: width,
          alignment: Alignment.center,
          child: Text(
            text,
            style: Styles().style_4,
          )),
    );
  }
}

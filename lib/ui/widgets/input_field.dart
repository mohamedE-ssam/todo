import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.icon,
    this.controller,
    this.readonly = false,
  }) : super(key: key);
  final String title;
  final String hint;
  final Widget? icon;
  final bool readonly;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles().style_5,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty && !readonly) {
                  return 'must not be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: primaryClr)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: primaryClr)),
                hintText: hint,
                suffixIcon: icon,
              ),
              cursorColor: Get.isDarkMode ? Colors.grey[200] : darkHeaderClr,
              controller: controller,
              readOnly: readonly,
            ),
          ),
        ],
      ),
    );
  }
}

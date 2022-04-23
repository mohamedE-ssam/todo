import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar(
        context: context,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Hello,',
              style: Styles().style_1,
            ),
            Text(
              'You have a new Reminder',
              style: Styles().style_2,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: primaryClr, borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      itembody(
                          payload: widget.payload.split('|')[0],
                          icon: Icons.text_format,
                          title: 'Title'),
                      itembody(
                          payload: widget.payload.split('|')[1],
                          icon: Icons.description,
                          title: 'Description'),
                      itembody(
                          payload: widget.payload.split('|')[2],
                          icon: Icons.calendar_today,
                          title: 'Date'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itembody(
        {required String payload,
        required IconData icon,
        required String title}) =>
    Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: white,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Styles().style_3,
                textAlign: TextAlign.justify,
              )
            ],
          ),
          Text(
            payload,
            style: Styles().style_4,
          ),
        ],
      ),
    );

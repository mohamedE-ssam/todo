import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../../ui/pages/add_task_page.dart';
import '../../ui/size_config.dart';
import '../../ui/theme.dart';
import '../../ui/widgets/appbar.dart';
import '../../ui/widgets/button.dart';
import '../../ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSpermissions();
    notifyHelper.initializationNotification();
    _taskController.getTask();
  }

  DateTime _dateTime = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: myappbar(
        context: context,
        leading: IconButton(
            onPressed: () {
              ThemeServices().swichmode();
            },
            icon: Icon(Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined)),
        actions: [
          IconButton(
            onPressed: () {
              _taskController.deleteAll();
              NotifyHelper().cancelAllNotification();
              Get.snackbar('Success', 'All tasks deleted',
                  backgroundColor: Theme.of(context).primaryColor,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Get.isDarkMode ? Colors.black : Colors.white);
            },
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
          const SizedBox(
            width: 5,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 17,
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          addTaskbar(),
          datepick((DateTime v) {
            setState(() {
              _dateTime = v;
            });
          }),
          showtasks(),
        ],
      ),
    );
  }

  showtasks() {
    return Expanded(child: Obx(
      () {
        if (_taskController.tasklist.isNotEmpty) {
          return ListView.builder(
            scrollDirection: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemCount: _taskController.tasklist.length,
            itemBuilder: (BuildContext context, int index) {
              Task task = _taskController.tasklist[index];
              //-----------------

//-------------------
              if (task.repeat == 'Daily' ||
                  task.date == DateFormat.yMd().format(_dateTime) ||
                  (task.repeat == 'Weekly' &&
                      _dateTime
                                  .difference(
                                      DateFormat.yMd().parse(task.date!))
                                  .inDays %
                              7 ==
                          0) ||
                  (task.repeat == 'Monthly' &&
                      DateFormat.yMd().parse(task.date!).day ==
                          _dateTime.day)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 1200),
                  child: SlideAnimation(
                    horizontalOffset: 300,
                    child: FadeInAnimation(child: TaskTile(task)),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: svgphoto(),
          );
        }
      },
    ));
  }

//-------------------------------------------------
  addTaskbar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: Styles().style_5,
                ),
                Text(
                  'Today',
                  style: Styles().style_1,
                )
              ],
            ),
            MyButton(
              ontap: () async {
                await Get.to(const AddTaskPage());
                _taskController.getTask();
              },
              text: '+ Add Task',
              height: 45,
            )
          ],
        ),
      );
}

svgphoto() => Stack(
      children: [
        SingleChildScrollView(
          child: Wrap(
            direction: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizeConfig.orientation == Orientation.landscape
                  ? const SizedBox(
                      height: 6,
                    )
                  : const SizedBox(
                      height: 150,
                    ),
              SvgPicture.asset(
                'images/task.svg',
                height: 90,
                color: primaryClr.withOpacity(0.5),
                semanticsLabel: 'Task',
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'You dont have any Tasks!\n Try add Some Tasks',
                  style: Styles().style_5,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
//-------------------------------------------------
datepick(Function onchange) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 65,
        selectionColor: primaryClr,
        dayTextStyle: Styles().style_2,
        dateTextStyle: Styles().style_2,
        monthTextStyle: Styles().style_2,
        onDateChange: (v) {
          onchange(v);
        },
      ),
    );
//-------------------------------------------------


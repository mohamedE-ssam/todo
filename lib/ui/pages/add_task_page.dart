import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/appbar.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../../controllers/task_controller.dart';
import '../../services/notification_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();
  //-----------------------------------------------------------------------
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endtTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  //-----------------------------------------------------------------------
  int _selectedRemind = 0;
  final List<int> _remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  final List<String> _repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  //------------------------------------
  int _selectcolor = 0;
  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappbar(
          context: context,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
              radius: 17,
            ),
            SizedBox(
              width: 10,
            )
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Add Task',
                    style: Styles().style_1,
                  ),
                  MyInputField(
                    title: 'Title',
                    hint: 'Enter Title here',
                    controller: _titlecontroller,
                  ),
                  MyInputField(
                    title: 'Note',
                    hint: 'Enter Note here',
                    controller: _notecontroller,
                  ),
                  MyInputField(
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedDate),
                    readonly: true,
                    icon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2200))
                            .then((value) {
                          setState(() {
                            _selectedDate = value ?? _selectedDate;
                          });
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyInputField(
                          title: 'Start time',
                          hint: _startTime,
                          readonly: true,
                          icon: IconButton(
                            icon: const Icon(Icons.timer),
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  value == null
                                      ? null
                                      : _startTime = value.format(context);
                                });
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: MyInputField(
                          title: 'End Time',
                          hint: _endtTime,
                          readonly: true,
                          icon: IconButton(
                            icon: const Icon(Icons.timer),
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  value == null
                                      ? null
                                      : _endtTime = value.format(context);
                                });
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  MyInputField(
                    title: 'Remind',
                    hint: '$_selectedRemind minutes only',
                    readonly: true,
                    icon: DropdownButton<int>(
                      items: _remindList
                          .map((e) => DropdownMenuItem<int>(
                                child: Text('$e'),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedRemind = val ?? _selectedRemind;
                        });
                      },
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                    ),
                  ),
                  MyInputField(
                    title: 'Repeat',
                    hint: _selectedRepeat,
                    readonly: true,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: DropdownButton<String>(
                        items: _repeatList
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedRepeat = val ?? _selectedRepeat;
                          });
                        },
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Color',
                            style: Styles().style_2,
                          ),
                          colorsShow(),
                        ],
                      ),
                      MyButton(
                        text: 'Add Task',
                        ontap: () async {
                          _formKey.currentState!.validate()
                              ? {
                                  await addtask(),
                                  _taskController.getTask(),
                                  notificationBuild(),
                                  Get.back()
                                }
                              : Null;
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //------------------------------------------------------------------
  Row colorsShow() => Row(
        children: List<Widget>.generate(
          3,
          (indx) => Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectcolor = indx;
                });
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: indx == 0
                    ? bluishClr
                    : indx == 1
                        ? orangeClr
                        : pinkClr,
                child: indx == _selectcolor ? const Icon(Icons.done) : null,
              ),
            ),
          ),
        ),
      );
  //------------------------------------------------------------------

  addtask() async {
    await _taskController
        .addtask(
            task: Task(
      title: _titlecontroller.text,
      note: _notecontroller.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endtTime,
      color: _selectcolor,
      isCompleted: 0,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
    ))
        .then((value) {
      debugPrint('$value');
      id = value;
    }).catchError((e) {
      debugPrint('$e error');
    });
  }
  //------------------------------------------------------------------

  notificationBuild() {
    DateTime date = DateFormat.jm().parse(_startTime);
    String mytime = DateFormat('HH:mm').format(date);
    String hour = mytime.split(':')[0];
    String minutes = mytime.split(':')[1];
    NotifyHelper().schedulingNotification(
      int.parse(hour),
      int.parse(minutes),
      Task(
        id: id,
        title: _titlecontroller.text,
        note: _notecontroller.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endtTime,
        color: _selectcolor,
        isCompleted: 0,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      ),
    );
  }
}

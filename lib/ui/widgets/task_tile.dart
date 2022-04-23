import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/ui/widgets/button.dart';
import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../ui/size_config.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task, {Key? key}) : super(key: key);
  final Task task;
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          buldbottomsheet(task),
          backgroundColor: context.theme.scaffoldBackgroundColor,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20),
        ),
        margin: EdgeInsets.only(
          bottom: getProportionateScreenHeight(12),
          top: getProportionateScreenHeight(12),
        ),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: getcolor(task),
          ),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title!,
                        style: Styles().style_1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Get.isDarkMode
                                ? const Color.fromARGB(255, 194, 191, 191)
                                : const Color.fromARGB(255, 37, 37, 37),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${task.startTime} - ${task.endTime}',
                            style: Styles().style_2,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        task.note!,
                        style: Styles().style_5,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 0.5,
                height: 60,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted == 0 ? 'ToDo' : 'Completed',
                  style: Styles().style_2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buldbottomsheet(Task task) => Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400]),
              width: SizeConfig.screenWidth / 2,
              height: 8,
            ),
            const SizedBox(
              height: 20,
            ),
            task.isCompleted == 0
                ? MyButton(
                    ontap: () {
                      _taskController.updateTask(task.id!);
                      NotifyHelper().cancelNotification(task.id!);
                      Get.back();
                    },
                    text: 'Make it Completed',
                    width: double.infinity,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              ontap: () {
                _taskController.deleteTask(task.id!);
                NotifyHelper().cancelNotification(task.id!);
                Get.back();
              },
              text: 'Delete Task',
              width: double.infinity,
              color: const Color.fromARGB(255, 245, 82, 70),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              ontap: () {
                Get.back();
              },
              text: 'Cancel',
              width: double.infinity,
            ),
          ],
        ),
      );
}

getcolor(Task task) {
  switch (task.color) {
    case 0:
      return bluishClr;
    case 1:
      return orangeClr;
    case 2:
      return pinkClr;
    default:
      return bluishClr;
  }
}

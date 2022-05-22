import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Model/task_model.dart';
import 'package:provider/provider.dart';

import '../../../Repo/Services/hive_services.dart';
import '../../../Utils/Constants/constants.dart';
import '../Widgets/included_tag_widget.dart';
import '../Widgets/priority_widget.dart';
import '../Widgets/tag_list_widget.dart';
import '../Widgets/title_widget.dart';

class AddTaskListCardScreen extends StatelessWidget {
  AddTaskListCardScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SCAFFOLD_BG_COLOR,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        isExtended: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 10,
        shape: const StadiumBorder(),
        label: Text(
          "Create",
          style: TextStyle(
              color: SCAFFOLD_BG_COLOR,
              letterSpacing: 0,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      appBar: AppBar(
        backgroundColor: SCAFFOLD_BG_COLOR,
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () {
            services.clearSelectedTag();
            Navigator.pop(context);
          },
        ),
        title: Text(
          "New Task List",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                TitleWidget(
                  titleController: titleController,
                ),
                TaskListWidget(),
                const IncludedTagWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const TagListWidget(),
                PriorityWidget(
                  priorityController: priorityController,
                ),
                SizedBox(
                  height: .2.sh,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<TaskModel>> tasks = ValueNotifier([]);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Tasks",
        style: TextStyle(
            color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w500),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: SizedBox(
                    height: 60.h,
                    child: TextField(
                      controller: _textEditingController,
                      onEditingComplete: () {
                        if (_textEditingController.text != "") {
                          tasks.value.add(
                              TaskModel(task: _textEditingController.text));

                          tasks.notifyListeners();

                          _textEditingController.clear();
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          suffix: TextButton(
                            onPressed: () {
                              if (_textEditingController.text != "") {
                                tasks.value.add(TaskModel(
                                    task: _textEditingController.text));

                                tasks.notifyListeners();

                                _textEditingController.clear();
                                FocusManager.instance.primaryFocus!.unfocus();
                              }
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(color: PRIMARY_COLOR),
                            ),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white24,
                              fontWeight: FontWeight.normal),
                          hintText: "Add Task",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(width: 0)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(width: 0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(
                                  width: 0, color: PRIMARY_GREEN))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ValueListenableBuilder(
                    valueListenable: tasks,
                    builder: (BuildContext context, List<TaskModel> taskList,
                        Widget? child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskList.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          TaskModel task = taskList[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.grey.withOpacity(.5)),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  task.icon,
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: SizedBox(
                                      child: Text(
                                        task.task,
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        tasks.value.remove(task);
                                        tasks.notifyListeners();
                                      },
                                      icon: const Icon(CupertinoIcons.clear))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

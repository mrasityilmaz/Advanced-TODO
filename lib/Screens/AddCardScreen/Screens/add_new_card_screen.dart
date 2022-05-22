import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mvvm_provider_todo/Repo/HiveModels/card_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/priority_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/home_screen.dart';

import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';
import 'package:provider/provider.dart';

import '../Widgets/desc_widget.dart';
import '../Widgets/included_tag_widget.dart';
import '../Widgets/priority_widget.dart';
import '../Widgets/tag_list_widget.dart';
import '../Widgets/title_widget.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({Key? key}) : super(key: key);

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
        onPressed: () async {
          await services.addCard(
              services.spacesBox.values
                  .toList()[HomeScreen.pageController.page!.toInt()]
                  .id,
              NormalCardHiveModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descController.text,
                  isPinned: false,
                  priority: priorityController.text == ""
                      ? null
                      : PriorityEnum.values.firstWhere((element) =>
                          element.name ==
                          (priorityController.text == ""
                              ? null
                              : priorityController.text)),
                  isDone: false,
                  tags: services.selectedTags,
                  spaceID: services.spacesBox.values.first.id,
                  createdDate: DateTime.now()));

          services.clearSelectedTag();

          Navigator.pop(context);
        },
        isExtended: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 10,
        shape: const StadiumBorder(),
        label: Text(
          "Create",
          style: TextStyle(
              letterSpacing: 0,
              color: SCAFFOLD_BG_COLOR,
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
          "New Card",
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
                TitleWidget(
                  titleController: titleController,
                ),
                DescriptionWidget(
                  descController: descController,
                ),
                const IncludedTagWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const TagListWidget(),
                PriorityWidget(
                  priorityController: priorityController,
                ),
                SizedBox(
                  height: 100.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

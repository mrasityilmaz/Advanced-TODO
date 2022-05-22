import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/group_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/Components/Cards/group_card.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';
import 'package:provider/provider.dart';

import '../HomeScreen/home_screen.dart';

class AddGroupScreen extends StatelessWidget {
  AddGroupScreen({Key? key}) : super(key: key);
  final HueController _hueController =
      HueController(HSVColor.fromColor(PRIMARY_COLOR));

  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();
    return Scaffold(
      backgroundColor: SCAFFOLD_BG_COLOR,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String spaceid = services.spacesBox.values
              .toList()[HomeScreen.pageController.page!.toInt()]
              .id;
          await services.addGroup(
              spaceid,
              GroupCardHiveModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _nameController.text,
                  childrens: [],
                  isPinned: false,
                  color: _hueController.value.toColor().value,
                  completedCount: 0,
                  allCount: 0,
                  spaceID: spaceid));

          Navigator.pop(context);
        },
        isExtended: true,
        backgroundColor: PRIMARY_COLOR,
        elevation: 10,
        shape: const StadiumBorder(),
        label: Text(
          "Create",
          style: TextStyle(
              color: SCAFFOLD_BG_COLOR,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      appBar: AppBar(
        backgroundColor: SCAFFOLD_BG_COLOR,
        title: Text(
          "New Group",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Group Name",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w500),
              ),
              contentPadding: EdgeInsets.zero,
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: TextField(
                  controller: _nameController,
                  onChanged: (str) {},
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white24,
                          fontWeight: FontWeight.normal),
                      hintText: "Type Something",
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
                  maxLength: 20,
                ),
              ),
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Group Color",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ValueListenableBuilder(
                      valueListenable: _hueController,
                      builder: (BuildContext context, HSVColor value,
                          Widget? child) {
                        return Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: value.toColor()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ValueListenableBuilder(
                  valueListenable: _hueController,
                  builder:
                      (BuildContext context, HSVColor value, Widget? child) {
                    return HuePicker(
                      trackHeight: 30.h,
                      controller: _hueController,
                      thumbShape: HueSliderThumbShape(
                          color: Colors.transparent,
                          radius: 15.w,
                          strokeWidth: 3.w,
                          filled: true,
                          showBorder: true),
                      onChanged: (clr) {
                        _hueController.value = (clr);
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: ListTile(
                title: Text(
                  "Preview",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500),
                ),
                contentPadding: EdgeInsets.zero,
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: ValueListenableBuilder(
                    valueListenable: _hueController,
                    builder: (BuildContext context, HSVColor hsvColor,
                        Widget? child) {
                      return ValueListenableBuilder(
                        valueListenable: _nameController,
                        builder: (BuildContext context, TextEditingValue value,
                            Widget? child) {
                          return Container(
                            decoration: BoxDecoration(
                                color: hsvColor.toColor(),
                                borderRadius: BorderRadius.circular(10.r)),
                            height: 70.h,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              value.text == "" ? "Group Name" : value.text,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

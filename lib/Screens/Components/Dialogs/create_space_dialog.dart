import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Model/space_model.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/space_content_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/bottom_work_areas.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Constants/constants.dart';
import '../../HomeScreen/home_screen.dart';

createNewSpace(BuildContext context) {
  final TextEditingController _spaceNameController = TextEditingController();
  final ValueNotifier<Map<bool, String>> textFieldError =
      ValueNotifier({false: ""});

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: SCAFFOLD_BG_COLOR,
          title: Center(
              child: Text(
            "Create Workspace",
            style: TextStyle(fontSize: 24.sp, color: Colors.white),
          )),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          actionsPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 10,
                    backgroundColor: PRIMARY_COLOR.withOpacity(.4),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            TextButton(
                onPressed: () async {
                  DatabaseServices services = context.read<DatabaseServices>();

                  if (_spaceNameController.text.trim() != "") {
                    services.addNewSpace(WorkspaceModel(
                        title: _spaceNameController.text, childrens: []));

                    Navigator.pop(context);

                    // Scroll new space
                    if (services.spacesBox.values.isNotEmpty &&
                        services.spacesBox.values.length != 1) {
                      BottomWorkAreas.currentPageIndex.value =
                          services.spacesBox.values.length - 1;
                      HomeScreen.pageController.animateToPage(
                          BottomWorkAreas.currentPageIndex.value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                      BottomWorkAreas.bottomPageController.animateToPage(
                          BottomWorkAreas.currentPageIndex.value,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    }
                  } else {
                    textFieldError.value = {true: "Workspace is required"};
                  }
                },
                style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    elevation: 10,
                    backgroundColor: PRIMARY_GREEN,
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ],
          content: Material(
            color: SCAFFOLD_BG_COLOR,
            child: SizedBox(
              width: .9.sw,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
                child: Wrap(
                  children: [
                    ListTile(
                      title: Text(
                        "Workspace Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      contentPadding: EdgeInsets.zero,
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: ValueListenableBuilder(
                          valueListenable: textFieldError,
                          builder: (BuildContext context,
                              Map<bool, String> value, Widget? child) {
                            return TextField(
                              controller: _spaceNameController,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              onChanged: (s) {
                                textFieldError.value = {false: ""};
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 15.sp),
                                  errorText: value.entries.first.key
                                      ? value.entries.first.value
                                      : null,
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
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

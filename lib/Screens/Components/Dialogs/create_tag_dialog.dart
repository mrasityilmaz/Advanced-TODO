import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/my_textfield.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';

createNewTag(BuildContext context) {
  final TextEditingController _tagNameController = TextEditingController();
  final HueController _hueController =
      HueController(HSVColor.fromColor(PRIMARY_COLOR));
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: SCAFFOLD_BG_COLOR,
          title: Center(
              child: Text(
            "Create Tag",
            style: TextStyle(fontSize: 24.sp, color: Colors.white),
          )),
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
                onPressed: () {},
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
            child: ValueListenableBuilder(
              valueListenable: _tagNameController,
              builder: (BuildContext context, TextEditingValue tagText,
                  Widget? child) {
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    MyTextFieldWidget(
                        hintText: "Tag Name",
                        textEditingController: _tagNameController),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: ValueListenableBuilder(
                        valueListenable: _hueController,
                        builder: (BuildContext context, dynamic value,
                            Widget? child) {
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
                              _hueController.value = clr;
                              _tagNameController.notifyListeners();
                            },
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: _hueController.value.toColor(),
                            borderRadius: BorderRadius.circular(15.r)),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        child: Text(
                          tagText.text == "" ? "Tag" : tagText.text,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      });
}

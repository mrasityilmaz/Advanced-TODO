import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/card_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/priority_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../Utils/Constants/constants.dart';

class NormalCardWidget extends StatelessWidget {
  final NormalCardHiveModel modelData;
  const NormalCardWidget({Key? key, required this.modelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          color: GROUP_CARD_COLOR.withOpacity(.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: TextButton.icon(
                onPressed: () {
                  log("messagebutton");
                },
                icon: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      await services.modifyNormalCard(modelData.spaceID,
                          modelData.id, 6, !modelData.isPinned);
                    },
                    alignment: Alignment.center,
                    icon: isPinnedFunc(modelData.isPinned)),
                label: Row(
                  children: [
                    Expanded(
                      child: Text(
                        modelData.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          await services.modifyNormalCard(modelData.spaceID,
                              modelData.id, 7, !modelData.isDone);
                        },
                        alignment: Alignment.center,
                        icon: isDone(modelData.isDone))
                  ],
                ),
                style: TextButton.styleFrom(
                    fixedSize: Size(.98.sw, 80.h),
                    elevation: 15,
                    primary: SCAFFOLD_BG_COLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    shadowColor: Colors.black.withOpacity(.7),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    backgroundColor: GROUP_CARD_COLOR),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    priorityFlag(modelData.priority),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text("Tags:",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(.4))),
                    Expanded(
                      flex: 8,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              modelData.tags.length,
                              (index) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: Text(
                                    modelData.tags[index].name + ",",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color(modelData.tags[index].tagColor),
                                    ),
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget isPinnedFunc(bool isPinned) {
    if (isPinned) {
      return Transform.rotate(
        angle: -math.pi / 4,
        child: Icon(
          CupertinoIcons.pin_fill,
          color: PRIMARY_COLOR,
          size: 30.w,
        ),
      );
    } else {
      return Icon(
        CupertinoIcons.pin_slash_fill,
        color: INACTIVE_BUTTON_COLOR,
        size: 30.w,
      );
    }
  }

  Widget isDone(bool isDone) {
    if (isDone) {
      return Icon(
        CupertinoIcons.check_mark_circled,
        color: Colors.greenAccent,
        size: 40.w,
      );
    } else {
      return Icon(
        CupertinoIcons.circle,
        color: INACTIVE_BUTTON_COLOR,
        size: 40.w,
      );
    }
  }

  Widget priorityFlag(PriorityEnum? priorityEnum) {
    switch (priorityEnum) {
      case PriorityEnum.Low:
        return Icon(
          CupertinoIcons.flag_fill,
          size: 25.w,
          color: Colors.grey,
        );
      case PriorityEnum.Normal:
        return Icon(
          CupertinoIcons.flag_fill,
          size: 25.w,
          color: Colors.green,
        );
      case PriorityEnum.High:
        return Icon(
          CupertinoIcons.flag_fill,
          size: 25.w,
          color: Colors.yellow,
        );
      case PriorityEnum.Urgent:
        return Icon(
          CupertinoIcons.flag_fill,
          size: 25.w,
          color: Colors.red,
        );

      default:
        return const SizedBox();
    }
  }
}


//  Text(
//                         "${modelData.createdDate.day}:${modelData.createdDate.month}:${modelData.createdDate.year}",
//                         style: TextStyle(
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white.withOpacity(.4))),
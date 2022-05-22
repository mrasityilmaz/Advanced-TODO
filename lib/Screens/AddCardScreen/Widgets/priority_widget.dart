import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Model/priority_model.dart';
import '../../../Utils/Constants/constants.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({
    Key? key,
    required this.priorityController,
  }) : super(key: key);

  final TextEditingController priorityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Text(
              "Priority",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    backgroundColor: PRIMARY_COLOR.withOpacity(.4)),
                onPressed: () {
                  priorityController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    "Clear",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ))
          ],
        ),
        subtitle: ValueListenableBuilder(
          valueListenable: priorityController,
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
            PriorityEnum s = PriorityEnum.values.firstWhere((element) =>
                element.name == (value.text == "" ? "Null" : value.text));
            PriorityModel? model = s.name == "Null"
                ? null
                : priorityList.firstWhere(
                    (element) {
                      return element.name == s.name;
                    },
                  );

            return CustomDropdown(
              hintText: "Select Priority",
              items: priorityList.map((e) => e.name).toList(),
              controller: priorityController,
              excludeSelected: false,
              onChanged: (str) {},
              fieldSuffixIcon: Icon(Icons.flag,
                  size: 30.sp, color: model?.flagColor ?? Colors.grey),
              hintStyle: TextStyle(
                fontSize: 18.sp,
              ),
              listItemStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
              selectedStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
              fillColor: SCAFFOLD_BG_COLOR,
            );
          },
        ),
      ),
    );
  }
}

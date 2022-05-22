import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/Constants/constants.dart';

class TitleWidget extends StatelessWidget {
  final TextEditingController titleController;
  const TitleWidget({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Title",
        style: TextStyle(
            color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w500),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: TextField(
          controller: titleController,
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
                  borderSide:
                      const BorderSide(width: 0, color: PRIMARY_GREEN))),
          maxLength: 40,
        ),
      ),
    );
  }
}

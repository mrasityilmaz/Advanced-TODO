import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Components/Dialogs/add_dialog.dart';
import '../../../Utils/Constants/constants.dart';

Widget floatingActionButton(BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(right: .25.sw - 70.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 15,
            primary: PRIMARY_COLOR,
            onPrimary: SCAFFOLD_BG_COLOR,
            shadowColor: PRIMARY_COLOR,
            fixedSize: Size(70.w, 70.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70))),
        onPressed: () {
          bottomAddDialog(context);
        },
        child: Icon(
          CupertinoIcons.add,
          size: 45.w,
          color: Colors.white,
        ),
      ));
}

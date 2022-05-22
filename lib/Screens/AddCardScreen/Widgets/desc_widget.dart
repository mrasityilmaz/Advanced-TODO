import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/Constants/constants.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController descController;
  const DescriptionWidget({Key? key, required this.descController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Description",
        style: TextStyle(
            color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.w500),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: SizedBox(
        height: .3.sh,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Stack(
                  children: [
                    TextField(
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
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
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                backgroundColor: PRIMARY_COLOR.withOpacity(.4)),
                            onPressed: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

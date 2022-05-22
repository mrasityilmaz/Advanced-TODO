import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCAFFOLD_BG_COLOR,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              Text(
                "Setting",
                style: GoogleFonts.baloo2(
                    color: PRIMARY_COLOR,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 30.h,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "Tamamlanan görevleri sil",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      value: true,
                      onChanged: (val) {},
                      activeColor: PRIMARY_COLOR,
                    )
                  ],
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shadowColor: SCAFFOLD_BG_COLOR.withAlpha(200),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                    backgroundColor: SCAFFOLD_BG_COLOR,
                    elevation: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "Sadece grupları göster",
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                      const Spacer(),
                      Switch.adaptive(
                        value: true,
                        onChanged: (val) {},
                        activeColor: PRIMARY_COLOR,
                      )
                    ],
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      shadowColor: SCAFFOLD_BG_COLOR.withAlpha(200),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      backgroundColor: SCAFFOLD_BG_COLOR,
                      elevation: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

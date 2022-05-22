import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/space_content_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/bottom_work_areas.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Constants/constants.dart';
import '../../../Utils/Constants/data_constants.dart';

import 'create_space_dialog.dart';

Future bottomAddDialog(BuildContext context) => showModalBottomSheet(
    backgroundColor: SCAFFOLD_BG_COLOR,
    elevation: 10,
    isDismissible: true,
    context: context,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: addMenu.length,
          itemBuilder: (BuildContext context, int index) {
            bool isBack = addMenu[index] == "Back";
            return Padding(
                padding: EdgeInsets.symmetric(vertical: isBack ? 80.h : 5.0),
                child: TextButton.icon(
                  icon: Icon(
                    isBack ? null : Icons.add,
                    size: isBack ? 0 : 40.h,
                    color: SCAFFOLD_BG_COLOR,
                  ),
                  label: Text(
                    addMenu[index],
                    style: TextStyle(
                        color: Colors.white, fontSize: isBack ? 26.sp : 22.sp),
                  ),
                  style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      elevation: 10,
                      backgroundColor: isBack
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(.5),
                      minimumSize: Size(double.infinity, 60.h),
                      alignment:
                          isBack ? Alignment.center : Alignment.centerLeft),
                  onPressed: () {
                    if (isBack) {
                      context.read<DatabaseServices>().deleteAllSpace();
                      BottomWorkAreas.currentPageIndex.value = 0;
                      Navigator.pop(context);
                    }
                    switch (index) {
                      case 0:
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/add-card");
                        break;
                      case 1:
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/add-tasklist");
                        break;
                      case 2:
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/add-group");
                        break;
                      case 3:
                        Navigator.pop(context);
                        createNewSpace(context);
                        break;
                      default:
                    }
                  },
                ));
          },
        ),
      );
    });

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/group_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/my_textfield.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Constants/constants.dart';
import '../home_screen.dart';

PreferredSizeWidget appBar() {
  return PreferredSize(
      preferredSize: Size(double.infinity, 50.h), child: MyAppBar());
}

class MyAppBar extends StatelessWidget {
  MyAppBar({
    Key? key,
  }) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();
    return AppBar(
        backgroundColor: SCAFFOLD_BG_COLOR,
        centerTitle: false,
        elevation: 0,
        title: services.selectableMode ? null : title(context),
        leading: services.selectableMode ? settingLeading(services) : null,
        actions: services.selectableMode ? settingWidgets(services) : null);
  }

  Widget title(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Todo+",
          style: GoogleFonts.fredokaOne(color: PRIMARY_COLOR, fontSize: 30.sp),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/setting");
            },
            icon: Icon(
              CupertinoIcons.settings_solid,
              size: 35.w,
            ))
      ],
    );
  }

  Widget settingLeading(DatabaseServices services) {
    return IconButton(
      onPressed: services.selectedCards.isNotEmpty
          ? () async {
              String spaceID = services.spacesBox.values
                  .toList()[HomeScreen.pageController.page!.toInt()]
                  .id;

              services.selectedCards.forEach((element) async {
                await services.removeCard(spaceID, element);
              });
              services.openOrCloseSelectableMode(false);
            }
          : null,
      icon: Icon(
        CupertinoIcons.trash,
        color: PRIMARY_COLOR,
        size: 30.w,
      ),
    );
  }

  List<Widget> settingWidgets(DatabaseServices services) {
    String spaceID = services.spacesBox.values
        .toList()[HomeScreen.pageController.page!.toInt()]
        .id;

    String? groupID = (services.spacesBox.values
            .where((element) => element.id == spaceID)
            .first
            .childrens
            .whereType<GroupCardHiveModel>()
            .first)
        .id;

    return [
      TextButton.icon(
        onPressed: () async {
          await services.moveToGroup(spaceID, groupID, services.selectedCards);
        },
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            backgroundColor: Colors.indigo.shade600.withOpacity(.7)),
        label: Text(
          "Move",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        icon: const Icon(
          CupertinoIcons.slider_horizontal_below_rectangle,
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: 10.w,
      ),
      TextButton(
        onPressed: () {
          services.openOrCloseSelectableMode(false);
        },
        child: Text(
          "Cancel",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            backgroundColor: PRIMARY_COLOR.withOpacity(.1)),
      ),
      SizedBox(
        width: 10.w,
      ),
    ];
  }
}

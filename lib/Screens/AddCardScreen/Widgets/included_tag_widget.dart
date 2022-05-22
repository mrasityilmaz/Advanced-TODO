import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/AddCardScreen/Widgets/tag_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../Model/tag_model.dart';

class IncludedTagWidget extends StatelessWidget {
  const IncludedTagWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 0, color: Colors.black),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Text(
            "Tags:",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.sp,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
              child: SizedBox(
            height: 60.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: services.selectedTags.length,
              itemBuilder: (BuildContext context, int index) {
                TagHiveModel item = services.selectedTags[index];
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ChoiceChip(
                        elevation: 5,
                        pressElevation: 10,
                        selectedColor: Color(item.tagColor),
                        onSelected: (isSelected) {},
                        backgroundColor: Color(item.tagColor),
                        label: Text(
                          item.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        selected: false));
              },
            ),
          )),
        ],
      ),
    );
  }
}

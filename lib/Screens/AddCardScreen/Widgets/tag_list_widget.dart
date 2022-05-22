import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/tag_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:provider/provider.dart';

import '../../../Model/tag_model.dart';
import '../../../Utils/Constants/constants.dart';
import '../../../Utils/Constants/data_constants.dart';
import '../../Components/Dialogs/create_tag_dialog.dart';

class TagListWidget extends StatelessWidget {
  const TagListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();

    return ListTile(
      title: Row(
        children: [
          Text(
            "Tags",
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
                createNewTag(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "New Tag",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              ))
        ],
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: SizedBox(
        height: 60.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: services.tagsBox.values.length,
          itemBuilder: (BuildContext context, int index) {
            TagHiveModel item = services.tagsBox.values.toList()[index];
            bool isSelectedItem =
                services.selectedTags.any((element) => element.id == item.id);
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: ChoiceChip(
                    elevation: 5,
                    pressElevation: 10,
                    avatar: isSelectedItem
                        ? const Icon(Icons.check_circle_outline_rounded)
                        : null,
                    selectedColor: PRIMARY_COLOR,
                    onSelected: (isSelected) {
                      if (isSelected && !isSelectedItem) {
                        services.selectTag(item.id);
                      } else {
                        services.unselectTag(item.id);
                      }
                    },
                    backgroundColor: Color(item.tagColor),
                    label: Text(
                      item.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                    selected: isSelectedItem));
          },
        ),
      ),
    );
  }
}

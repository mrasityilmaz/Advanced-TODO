import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/my_textfield.dart';

import '../../../Model/search_filters_model.dart';
import '../../../Utils/Constants/constants.dart';
import '../../../Utils/Constants/data_constants.dart';

class MySliverAppBar extends StatelessWidget {
  MySliverAppBar({Key? key}) : super(key: key);

  final ValueNotifier<List<SearchItemModel>> searchTag =
      ValueNotifier(searchTagInitialData);
  final ValueNotifier<bool> isShowFilterTags = ValueNotifier(false);

  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return ValueListenableBuilder(
      valueListenable: isShowFilterTags,
      builder: (BuildContext context, bool isShow, Widget? child) {
        return SliverAppBar(
          backgroundColor: Colors.transparent,
          floating: true,
          elevation: 0,
          bottom: isShow
              ? PreferredSize(
                  preferredSize: const Size(double.infinity, 50),
                  child: ValueListenableBuilder(
                    valueListenable: searchTag,
                    builder: (BuildContext context, List<SearchItemModel> value,
                        Widget? child) {
                      return SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: searchTagInitialData.length,
                          itemBuilder: (BuildContext context, int index) {
                            SearchItemModel item = value[index];
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: ChoiceChip(
                                    elevation: 5,
                                    pressElevation: 10,
                                    avatar: item.selected
                                        ? const Icon(
                                            Icons.check_circle_outline_rounded)
                                        : null,
                                    selectedColor: PRIMARY_COLOR,
                                    onSelected: (isSelected) {
                                      value[index].selected = isSelected;
                                      searchTag.notifyListeners();
                                    },
                                    disabledColor: SCAFFOLD_BG_COLOR,
                                    label: Text(
                                      item.name,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    selected: item.selected));
                          },
                        ),
                      );
                    },
                  ),
                )
              : null,
          leading: IconButton(
            onPressed: () {
              if (isShowFilterTags.value) {
                isShowFilterTags.value = false;
              } else {
                isShowFilterTags.value = true;
              }
            },
            icon: const Icon(
              CupertinoIcons.line_horizontal_3_decrease,
              size: 30,
            ),
          ),
          actions: [
            SizedBox(
              width: queryData.size.width * .8,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 8,
                        child: MyTextFieldWidget(
                            hintText: "Search in Space",
                            suffixIcon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                            textEditingController: _textEditingController)),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/group_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/taskcard_adapter.dart';
import 'package:mvvm_provider_todo/Screens/Components/Cards/group_card.dart';
import 'package:mvvm_provider_todo/Screens/HomeScreen/Widgets/my_divider.dart';

import 'package:provider/provider.dart';
import 'package:list_ext/list_ext.dart' as ext;
import 'package:simple_grouped_listview/simple_grouped_listview.dart';
import '../../Repo/HiveModels/card_adapter.dart';
import '../../Repo/HiveModels/space_content_adapter.dart';
import '../../Repo/Services/hive_services.dart';
import '../../Utils/Constants/constants.dart';
import '../Components/Cards/normal_card.dart';
import '../Components/Dialogs/create_space_dialog.dart';

class WorkPage extends StatelessWidget {
  final String? currentSpaceID;
  WorkPage({Key? key, this.currentSpaceID}) : super(key: key);

  final ValueNotifier<bool> isSelectedMode = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    DatabaseServices databaseServices = context.watch<DatabaseServices>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: ui(context, databaseServices),
    );
  }

  ui(BuildContext context, DatabaseServices services) {
    if (currentSpaceID == null) {
      return Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                "Welcome Todo+",
                textAlign: TextAlign.center,
                style: GoogleFonts.fredokaOne(shadows: [
                  Shadow(
                      color: PRIMARY_COLOR.withOpacity(.2),
                      blurRadius: 5.r,
                      offset: const Offset(1, 5))
                ], color: PRIMARY_COLOR, fontSize: 30.sp),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                SizedBox(
                  width: .6.sw,
                  height: .26.sh,
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: TextButton.icon(
                      onPressed: () {
                        createNewSpace(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.add,
                        color: SCAFFOLD_BG_COLOR,
                        size: 70,
                      ),
                      label: Transform.rotate(
                        angle: -math.pi / 2,
                        child: Text(
                          "Firstly add\n a Workspace",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 24.sp),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          // CenterRight because *rotate
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.zero,
                          primary: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          elevation: 10,
                          backgroundColor: Colors.grey.shade600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (services.spacesBox.isNotEmpty &&
        services.getCurrentSpace(currentSpaceID) != null &&
        services.getCurrentSpace(currentSpaceID)!.childrens.isEmpty) {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Now click",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: PRIMARY_COLOR),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: PRIMARY_COLOR),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                "button",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    color: PRIMARY_COLOR),
              )
            ],
          ),
          Text(
            "to add a task",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.sp,
                color: PRIMARY_COLOR),
          )
        ],
      ));
    }
    if (services.getCurrentSpace(currentSpaceID)!.childrens.isNotEmpty) {
      ScrollController _scrollController = ScrollController();
      ValueNotifier<String> searchh = ValueNotifier("");
      SpaceContentHiveModel page = services.getCurrentSpace(currentSpaceID!)!;
      return Center(
          child: Column(
        children: [
          services.selectableMode
              ? selectableModeAppBarBottom(services)
              : Expanded(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              searchh.value = value;
                            },
                            cursorColor: PRIMARY_COLOR,
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                            decoration: InputDecoration.collapsed(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    fontSize: 20.sp, color: Colors.white54)),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 30.w,
                          color: Colors.white54,
                        )
                      ],
                    ),
                  ),
                )),
          Expanded(
              flex: 12,
              child: ValueListenableBuilder(
                  valueListenable: searchh,
                  builder: (BuildContext context, String value, Widget? child) {
                    List<Object> unCompletedList = page.childrens
                        .where((element) =>
                            element is! GroupCardHiveModel &&
                            (element as dynamic).isDone != true &&
                            (element as dynamic).groupID == null)
                        .toList();

                    List<Object> completedList = page.childrens
                        .where((element) =>
                            element is! GroupCardHiveModel &&
                            (element as dynamic).isDone == true &&
                            (element as dynamic).groupID == null)
                        .toList();

                    List<GroupCardHiveModel> groupsList =
                        page.childrens.whereType<GroupCardHiveModel>().toList();

                    List<Object> groupWidgets = page.childrens
                        .where((element) =>
                            element is! GroupCardHiveModel &&
                            (element as dynamic).groupID != null)
                        .toList();

                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          children: [
                            Column(
                                children:
                                    List.generate(groupsList.length, (index) {
                              var list = groupWidgets
                                  .where((element) =>
                                      (element as dynamic).groupID ==
                                      groupsList[index].id)
                                  .toList();
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: GroupCard(
                                    titleText: groupsList[index].title,
                                    baseColor: Color(groupsList[index].color),
                                    compStatCount:
                                        groupsList[index].completedCount,
                                    allStatCount: groupsList[index].allCount,
                                    children:
                                        List.generate(list.length, (indexlist) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: NormalCardWidget(
                                            modelData: (list[indexlist]
                                                as NormalCardHiveModel)),
                                      );
                                    })),
                              );
                            })),

                            unCompletedList.isNotEmpty
                                ? const MyDivider(
                                    dividerTitle: "Uncompleted",
                                    dividerColor: Colors.red)
                                : const SizedBox(),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: unCompletedList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onLongPress: () {
                                      services.openOrCloseSelectableMode(
                                          !services.selectableMode);
                                    },
                                    child: selectableOrUnSelectable(
                                        services, unCompletedList[index]));
                              },
                            ),

                            completedList.isNotEmpty
                                ? const MyDivider(
                                    dividerTitle: "Completed",
                                    dividerColor: Colors.green)
                                : const SizedBox(),

                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: completedList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onLongPress: () {
                                      services.openOrCloseSelectableMode(
                                          !services.selectableMode);
                                    },
                                    child: selectableOrUnSelectable(
                                        services, completedList[index]));
                              },
                            ),
                            // SingleChildScrollView(
                            //   physics: BouncingScrollPhysics(),
                            //   child: Column(
                            //     children: [
                            //       GroupedListView(
                            //           reverse: true,
                            //           items: page.childrens
                            //               .where((element) =>
                            //                   element is! GroupCardHiveModel)
                            //               .toList(),
                            //           headerBuilder: (context, bool isDone) {
                            //             if (isDone) {
                            //               return MyDivider(
                            //                   dividerTitle: "Completed",
                            //                   dividerColor: Colors.green);
                            //             } else {
                            //               return MyDivider(
                            //                   dividerTitle: "Uncompleted",
                            //                   dividerColor: Colors.red);
                            //             }
                            //           },
                            //           physics: BouncingScrollPhysics(),
                            //           itemsBuilder:
                            //               (context, items) => ListView.builder(
                            //                     controller: _scrollController,
                            //                     shrinkWrap: true,
                            //                     scrollDirection: Axis.vertical,
                            //                     itemCount: items.length,
                            //                     itemBuilder:
                            //                         (BuildContext context,
                            //                             int index) {
                            //                       return GestureDetector(
                            //                           onLongPress: () {
                            //                             services.openOrCloseSelectableMode(
                            //                                 !services
                            //                                     .selectableMode);
                            //                           },
                            //                           child:
                            //                               selectableOrUnSelectable(
                            //                                   services,
                            //                                   items[index]!));
                            //                     },
                            //                   ),
                            //           itemGrouper: (ss) =>
                            //               (ss as NormalCardHiveModel).isDone),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ));
    }
  }

  selectableModeAppBarBottom(DatabaseServices services) {
    return Row(
      children: [
        SizedBox(
          width: 10.w,
        ),
        Text.rich(
          TextSpan(
            text: services.selectedCards.length.toString(),
            children: [
              TextSpan(
                text: "\t\t Items selected",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        TextButton(
            onPressed: () async {
              await services.selectAllCards(currentSpaceID!);
            },
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                backgroundColor: Colors.white12),
            child: Text(
              "Select All",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }

  selectableOrUnSelectable(DatabaseServices services, Object card) {
    if (services.selectableMode) {
      return Row(
        children: [
          Expanded(
              child: Checkbox(
            activeColor: PRIMARY_COLOR,
            value: services.selectedCards.any((element) =>
                (element as NormalCardHiveModel).id ==
                (card as NormalCardHiveModel).id),
            onChanged: (changedValue) {
              if (changedValue!) {
                services.addSelectedCards((card as NormalCardHiveModel));
              } else if (!changedValue) {
                services.removeSelectedCards((card as NormalCardHiveModel));
              }
            },
          )),
          Expanded(
            flex: 9,
            child: GestureDetector(
                onTap: () {
                  bool isSelected = services.selectedCards.any((element) =>
                      (element as NormalCardHiveModel).id ==
                      (card as NormalCardHiveModel).id);
                  if (!isSelected) {
                    services.addSelectedCards((card as NormalCardHiveModel));
                  } else if (isSelected) {
                    services.removeSelectedCards((card as NormalCardHiveModel));
                  }
                },
                child: SizedBox(
                  child: AbsorbPointer(
                      child: NormalCardWidget(
                          modelData: card as NormalCardHiveModel)),
                )),
          )
        ],
      );
    } else {
      return NormalCardWidget(modelData: card as NormalCardHiveModel);
    }
  }
}

//  reOrderList.sort(((a, b) {
//                     if (a is NormalCardHiveModel &&
//                         b is NormalCardHiveModel) {
//                       return a.isDone && !b.isDone ? 1 : -1;
//                     } else if (a is NormalCardHiveModel &&
//                         b is TaskCardHiveModel) {
//                       return a.isDone && !b.isDone ? 1 : -1;
//                     } else if (a is TaskCardHiveModel &&
//                         b is TaskCardHiveModel) {
//                       return a.isDone && !b.isDone ? 1 : -1;
//                     } else {
//                       return 0;
//                     }
//                   }));

//                   if ((reOrderList[index] is NormalCardHiveModel &&
//                                 (reOrderList[index] as NormalCardHiveModel)
//                                     .isDone) ||
//                             (reOrderList[index] is TaskCardHiveModel &&
//                                 (reOrderList[index] as TaskCardHiveModel)
//

//  return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                             itemCount: unCompletedList.length,
//                             itemBuilder: ((context, index) {
//                               if (value.trim().isNotEmpty) {
//                                 if ((unCompletedList[index]
//                                             as NormalCardHiveModel)
//                                         .title
//                                         .toLowerCase()
//                                         .contains(value.toLowerCase()) ||
//                                     (unCompletedList[index]
//                                             as NormalCardHiveModel)
//                                         .description
//                                         .toLowerCase()
//                                         .contains(value.toLowerCase()) ||
//                                     (unCompletedList[index]
//                                             as NormalCardHiveModel)
//                                         .tags
//                                         .any((element) => element.name
//                                             .toLowerCase()
//                                             .contains(value.toLowerCase()))) {
//                                   return GestureDetector(
//                                       onLongPress: () {
//                                         services.openOrCloseSelectableMode(
//                                             !services.selectableMode);
//                                       },
//                                       child: selectableOrUnSelectable(
//                                           services, unCompletedList[index]));
//                                 } else {
//                                   return const SizedBox();
//                                 }
//                               } else {
//                                 return GestureDetector(
//                                     onLongPress: () {
//                                       services.openOrCloseSelectableMode(
//                                           !services.selectableMode);
//                                     },
//                                     child: selectableOrUnSelectable(
//                                         services, unCompletedList[index]));
//                               }
//                             })),
//                       ),
//                     ],
//                   );

import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';

class BottomWorkAreas extends StatelessWidget {
  const BottomWorkAreas({
    Key? key,
  }) : super(key: key);

  static final PageController bottomPageController =
      PageController(initialPage: 0);

  static final ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    DatabaseServices services = context.watch<DatabaseServices>();

    return Container(
      decoration: const BoxDecoration(
        color: SCAFFOLD_BG_COLOR,
      ),
      height: 100.h,
      child: Padding(
          padding: EdgeInsets.only(
            right: .25.sw,
          ),
          child: SizedBox(
            width: .75.sw,
            height: 60.h,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: bottomPageController,
                    physics: services.selectableMode
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    itemCount: services.spacesBox.values.length,
                    onPageChanged: (index) {
                      currentPageIndex.value = index;

                      HomeScreen.pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                    itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Center(
                          child: SizedBox(
                            child: Text(
                              services.spacesBox.values.toList()[index].title,
                              style: const TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ))),
                  ),
                ),
                dots(services),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          )),
    );
  }

  dots(DatabaseServices services) {
    if (services.spacesBox.isNotEmpty) {
      return Expanded(
        flex: 2,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(
            valueListenable: currentPageIndex,
            builder: (BuildContext context, int value, Widget? child) {
              return DotsIndicator(
                  position: value.toDouble(),
                  decorator: const DotsDecorator(
                      color: Colors.white,
                      activeColor: PRIMARY_COLOR,
                      size: Size.square(5)),
                  dotsCount: services.spacesBox.values.length);
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

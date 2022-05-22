import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Repo/Services/hive_services.dart';
import 'Widgets/app_bar.dart';
import 'Widgets/bottom_work_areas.dart';
import 'Widgets/floating_button.dart';
import '../../Utils/Constants/constants.dart';
import '../../main.dart';
import 'page_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    DatabaseServices databaseServices = context.watch<DatabaseServices>();

    return Scaffold(
      backgroundColor: SCAFFOLD_BG_COLOR,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: databaseServices.spacesBox.isNotEmpty
          ? floatingActionButton(context)
          : null,
      appBar: appBar(),
      bottomNavigationBar: const BottomWorkAreas(),
      body: databaseServices.spacesBox.isNotEmpty
          ? PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: databaseServices.spacesBox.values.length,
              controller: HomeScreen.pageController,
              onPageChanged: (index) {},
              itemBuilder: (context, index) => WorkPage(
                currentSpaceID:
                    databaseServices.spacesBox.values.toList()[index].id,
              ),
            )
          : WorkPage(
              currentSpaceID: null,
            ),
    );
  }
}

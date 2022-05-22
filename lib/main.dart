import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_provider_todo/Model/space_model.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/priority_adapter.dart';
import 'package:mvvm_provider_todo/Repo/HiveModels/space_content_adapter.dart';
import 'package:mvvm_provider_todo/Repo/Services/hive_services.dart';
import 'package:mvvm_provider_todo/Screens/Components/Cards/normal_card.dart';
import 'package:mvvm_provider_todo/Screens/Components/Dialogs/create_space_dialog.dart';
import 'package:mvvm_provider_todo/Screens/SettingScreen/settings_screen.dart';
import 'package:mvvm_provider_todo/ViewModel/todo_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Repo/HiveModels/card_adapter.dart';
import 'Repo/HiveModels/group_adapter.dart';

import 'Repo/HiveModels/tag_adapter.dart';
import 'Repo/HiveModels/task_adapter.dart';
import 'Repo/HiveModels/taskcard_adapter.dart';
import 'Screens/AddCardScreen/Screens/add_new_card_screen.dart';
import 'Screens/AddCardScreen/Screens/add_tasklist_card_screen.dart';
import 'Screens/AddGroupScreen/add_group_screen.dart';
import 'Screens/HomeScreen/home_screen.dart';
import 'Utils/Constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();

  // Hive Initialize
  Hive.init(document.path);
  //*

  // Hive Adapter Register
  Hive.registerAdapter(PriorityEnumAdapter());
  Hive.registerAdapter(TagHiveModelAdapter());
  Hive.registerAdapter(TaskHiveModelAdapter());
  Hive.registerAdapter(NormalCardHiveModelAdapter());
  Hive.registerAdapter(TaskCardHiveModelAdapter());
  Hive.registerAdapter(GroupCardHiveModelAdapter());
  Hive.registerAdapter(SpaceContentHiveModelAdapter());
  //*

  // Open All Box
  await Hive.openBox<TagHiveModel>(tagsKey);
  await Hive.openBox<SpaceContentHiveModel>(spaceContentKey);

  await DatabaseServices().init();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DatabaseServices())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context) => MaterialApp(
        title: 'Advanced-TODO',
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: SCAFFOLD_BG_COLOR),
          fontFamily: GoogleFonts.baloo2().fontFamily,
          textTheme: const TextTheme(),
        ),
        routes: {
          "/": (context) => const HomeScreen(),
          "/add-card": (context) => AddCardScreen(),
          "/add-tasklist": (context) => AddTaskListCardScreen(),
          "/add-group": (context) => AddGroupScreen(),
          "/setting": (context) => const SettingScreen(),
        },
      ),
    );
  }
}

String longText =
    """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum""";

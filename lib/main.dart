import 'package:admin_pannel_monotor/dashboard.dart';
import 'package:admin_pannel_monotor/helpers/services/navigation_service.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_notifier.dart';
import 'package:admin_pannel_monotor/helpers/theme/app_style.dart';
import 'package:admin_pannel_monotor/helpers/theme/theme_customizer.dart';
import 'package:admin_pannel_monotor/widgets/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  AppStyle.init();
  

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, notifier, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          getPages: getPageRoute(),
           home: DashboardPage()
        );
      },
    );
  }
}
//

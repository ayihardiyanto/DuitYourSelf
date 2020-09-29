import 'package:duit_yourself/common/constants/key_pref_constants.dart';
import 'package:duit_yourself/common/routes/routing.dart';
import 'package:duit_yourself/precached_images.dart';
import 'package:duit_yourself/presentation/themes/setting_notifier.dart';
import 'package:duit_yourself/presentation/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
void main() => SharedPreferences.getInstance().then((prefs) {

      var entity = prefs.getString(KeyPrefConstants.entity);
      SettingNotifier settingNotifier = SettingNotifier();
      SettingNotifier.setEntity = entity ?? 'px';
      settingNotifier.setTheme(pxAppTheme);
      print(WidgetsBinding.instance.window.locale);
      print(SettingNotifier.entityParent);
      print(SettingNotifier.getEntity);

      runApp(
        ChangeNotifierProvider<SettingNotifier>(
          create: (_) => settingNotifier,
          child: MyApp(),
        ),
      );
    });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precachedImage(context);
    final themeNotifier = Provider.of<SettingNotifier>(context);
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: themeNotifier.getTheme(),
        debugShowCheckedModeBanner: false,
        home: RouteGenerator.buildLoginScreen(),
      ),
    );
  }
}

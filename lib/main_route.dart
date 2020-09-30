import 'package:duit_yourself/common/config/locator.dart';
import 'package:duit_yourself/common/routes/routes.dart';
import 'package:duit_yourself/common/routes/routing.dart';
import 'package:duit_yourself/common/services/navigation_service.dart';
import 'package:duit_yourself/presentation/themes/setting_notifier.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainRoute extends StatelessWidget {
  final String initialRoute;
  const MainRoute({Key key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('authenticated');
    final themeNotifier = Provider.of<SettingNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      builder: (context, child) => LayoutTemplate(
        child: child,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: initialRoute ?? Routes.welcomeScreen,
    );
  }
}

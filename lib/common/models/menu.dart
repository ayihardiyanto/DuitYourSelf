import 'package:flutter/material.dart';
import 'package:duit_yourself/common/routes/routes.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/menu/sidebar_menu_icons_icons.dart';

class Menu {
  String title;
  IconData icon;
  String route;

  Menu({this.title, this.icon, this.route});
}

List<Menu> menuItemsHrops = [
  Menu(title: 'Task Center', icon: SidebarMenuIcons.task_center_icon , route: Routes.taskCenter),
//comming soon development
//  Menu(title: 'News/Announcement', icon: SidebarMenuIcons.news_icon, route: Routes.dummyBScreen),
//  Menu(title: 'Change Onboarding', icon: SidebarMenuIcons.onboarding_icon, route: Routes.dummyCScreen),
  Menu(title: 'Mood Meter',icon: SidebarMenuIcons.insert_emoticon,route: Routes.moodMeterList)
];

List<Menu> menuItemsRecruiter = [
  Menu(title: 'Candidate Center', icon: Icons.people),
];
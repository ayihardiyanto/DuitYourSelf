import 'dart:async';

import 'package:duit_yourself/presentation/screens/dashboard/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/base_layout.dart';
import 'package:duit_yourself/presentation/screens/dashboard/dashboard_string.dart';
import 'package:duit_yourself/presentation/screens/dashboard/left_home_screen.dart';
import 'package:duit_yourself/presentation/screens/dashboard/profile/profile_edit.dart';
import 'package:duit_yourself/presentation/screens/dashboard/right_home_screen.dart';
import 'package:duit_yourself/presentation/screens/dashboard/top_right_widget.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Dashboard extends StatefulWidget {
  final bool isInitialUser;
  final String imageUrl;
  final String username;

  const Dashboard({
    Key key,
    this.isInitialUser,
    this.imageUrl,
    this.username,
  }) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  bool isProfileMenu = false;
  bool isHoldHover = false;
  bool textHover = false;
  bool isProfile = false;
  Timer timer;
  TextEditingController searchController = TextEditingController();
  AppBarBloc appBarBloc;
  AuthenticationBloc authenticationBloc;
  TabController profileTab;
  DashboardBloc dashboardBloc;
  String username = '';
  String imageUrl = '';
  String headline = '';
  AnimationController controller;
  Animation<Offset> offset;

  void onHoverProfile(bool showMenus) {
    // if (!isProfile) {
    //   setState(() {
    //     isProfileMenu = showMenus;
    //     isHoldHover = showMenus;
    //   });
    // }
  }

  final dashboardKey = GlobalKey<_DashboardState>();

  @override
  void initState() {
    super.initState();
    appBarBloc = BlocProvider.of<AppBarBloc>(context);
    appBarBloc.add(GetUserData());
    profileTab = TabController(length: 1, vsync: this);
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    searchController.addListener(() {
      setState(() {});
    });
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final dropdownW = width * 0.14;
    // final respPosDDW = dropdownW > 190 ? 190 : dropdownW;

    return Scaffold(
      backgroundColor: White.smokeWhite,
      appBar: AppBar(
        key: dashboardKey,
        automaticallyImplyLeading: false,
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              child: GestureDetector(
                onTap: () {
                  dashboardBloc.add(Home());
                },
                child: Text(
                  'DuitYourself',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Yellow.mangoYellow,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          BlocConsumer<AppBarBloc, AppBarState>(
            listener: (context, state) {
              if (state is DataLoaded) {
                username = state.displayName;
                imageUrl = state.photo;
                headline = state.headline;
              }
            },
            builder: (context, state) {
              if (state is GetDataLoading) {
                return Shimmer(
                  child: TopRightWidget(
                    isShimmer: true,
                    isInitialUser: false,
                  ),
                );
              }
              return TopRightWidget(
                isShimmer: false,
                imageUrl: imageUrl == '' ? null : imageUrl,
                isInitialUser: widget.isInitialUser,
                username: username,
                headline: headline,
                onHoverProfile: () {
                  dashboardBloc.add(
                    OpenProfile(
                      name: username,
                      image: Container(
                        width: width * 0.25,
                        height: height * 0.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageUrl == null
                                ? AssetImage(DashboardString.profileDefault)
                                : NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                isProfile = true;
                return SlideTransition(
                  position: offset,
                  child: ProfileEdit(
                    bloc: appBarBloc,
                    dashboardBloc: dashboardBloc,
                    arguments: onHoverProfile,
                    image: imageUrl == null || imageUrl == ''
                        ? AssetImage(DashboardString.profileDefault)
                        : NetworkImage(imageUrl),
                  ),
                );
              }
              if (state is SavingProfile) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is ProfileSaved) {
                appBarBloc.add(GetUserData());
              }
              if (state is ToHome) {
                isProfile = false;
                return BaseLayout(
                  leftColumn: LeftHomeScreen(
                    searchController: searchController,
                  ),
                  rightColumn: RightHomeScreen(
                    username: username,
                  ),
                  arguments: onHoverProfile,
                );
              }
              return BaseLayout(
                leftColumn: LeftHomeScreen(
                  searchController: searchController,
                ),
                rightColumn: RightHomeScreen(
                  username: username,
                ),
                arguments: onHoverProfile,
              );
            },
          ),
          // if (isProfileMenu)
          //   Positioned(
          //     right: respPosDDW,
          //     child: MouseRegion(
          //       onHover: (event) {
          //         onHoverProfile(true);
          //       },
          //       onExit: (event) {
          //         onHoverProfile(false);
          //       },
          //       child: Card(
          //         elevation: 5,
          //         child: AnimatedContainer(
          //           duration: Duration(seconds: 1),
          //           curve: Curves.slowMiddle,
          //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //           color: Colors.white,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               GestureDetector(
          //                 onTap: () {

          //                 },
          //                 child: MouseRegion(
          //                   onHover: (event) {
          //                     textHover = true;
          //                   },
          //                   onExit: (event) => textHover = false,
          //                   cursor: SystemMouseCursors.click,
          //                   child: FittedBox(
          //                     child: Text(
          //                       'Edit Your Profile',
          //                       style: PxText.contentText.copyWith(
          //                           color: textHover
          //                               ? Blue.lightNavy
          //                               : Black.lightBlack,
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

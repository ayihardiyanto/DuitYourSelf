import 'dart:async';

import 'package:duit_yourself/presentation/screens/dashboard/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/top_right_widget.dart';
import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/material.dart';
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

class _DashboardState extends State<Dashboard> {
  bool isProfileMenu = false;
  bool isHoldHover = false;
  bool textHover = false;
  Timer timer;
  TextEditingController searchController = TextEditingController();
  AppBarBloc appBarBloc;
  AuthenticationBloc authenticationBloc;
  String username = '';
  String imageUrl = '';

  void onHoverProfile(bool showMenus) {
    setState(() {
      isProfileMenu = showMenus;
      isHoldHover = showMenus;
    });
  }

  @override
  void initState() {
    super.initState();
    appBarBloc = BlocProvider.of<AppBarBloc>(context);
    appBarBloc.add(GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dropdownW = width * 0.14;
    final respPosDDW = dropdownW > 190 ? 190 : dropdownW;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     widget.imageUrl.trim();
    //   });
    // });

    return Scaffold(
      appBar: AppBar(
        // leading:
        // leadingWidth: MediaQuery.of(context).size.width,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: width * 0.5,
                    child: TextFieldDuit(
                      controller: searchController,
                      hintText: 'Find Opportunity',
                      fillColor: Grey.brightGrey,
                      borderColor: Grey.greyedText,
                      focusedBorderColor: Black.black,
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Blue.lightNavy,
                        onPressed: () {},
                      ),
                      suffixIcon: searchController.text.isEmpty
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Blue.lightNavy,
                              ),
                              onPressed: () {
                                searchController.clear();
                              }),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 9, 9, 9),
                      child: CustomFlatButton(
                          buttonTitle: 'Search', onPressed: () {}),
                    ))
              ],
            ),
          ),
          BlocConsumer<AppBarBloc, AppBarState>(
            listener: (context, state) {
              if (state is DataLoaded) {
                username = state.displayName;
                imageUrl = state.photo;
                print('USERNAME : $username, IMAGE : $imageUrl');
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
                username: widget.username,
                onHoverProfile: onHoverProfile,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MouseRegion(
            onHover: (event) => onHoverProfile(false),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.02,
                      top: height * 0.02,
                      right: width * 0.01,
                      bottom: height * 0.02,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: White.smokeWhite,
                            ),
                            child: Text(''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.005,
                      top: height * 0.02,
                      right: width * 0.01,
                      bottom: height * 0.02,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: White.smokeWhite,
                            ),
                            child: Text(''),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isProfileMenu)
            Positioned(
              right: respPosDDW,
              child: MouseRegion(
                onHover: (event) {
                  onHoverProfile(true);
                },
                onExit: (event) {
                  onHoverProfile(false);
                },
                child: Card(
                  elevation: 5,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.slowMiddle,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MouseRegion(
                          onHover: (event) {
                            textHover = true;
                          },
                          onExit: (event) => textHover = false,
                          cursor: SystemMouseCursors.click,
                          child: FittedBox(
                            child: Text(
                              'Edit Your Profile',
                              style: PxText.contentText.copyWith(
                                  color: textHover
                                      ? Blue.lightNavy
                                      : Black.lightBlack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

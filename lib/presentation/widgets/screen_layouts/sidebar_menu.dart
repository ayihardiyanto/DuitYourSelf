import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:duit_yourself/common/config/locator.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';
import 'package:duit_yourself/common/models/menu.dart';
import 'package:duit_yourself/common/services/navigation_service.dart';
import 'package:duit_yourself/common/routes/routes.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/menu/bloc/menu_bloc.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/menu/menu_item_tile.dart';

class SideBarMenu extends StatefulWidget {
  @override
  _SideBarMenuState createState() => _SideBarMenuState();
  final String name;
  final String photo;
  final String role;
  SideBarMenu({Key key, this.role, this.name, this.photo}) : super(key: key);
}

class _SideBarMenuState extends State<SideBarMenu>
    with SingleTickerProviderStateMixin {
  double maxWidth = 220;
  double minWidth = 60;
  bool collapsed = false;
  int selectedIndex = 99;
  MenuBloc menuBloc;
  List<Menu> menuData;
  String role;

  List<String> dummyRoutes = [
    Routes.taskCenter,
    Routes.moodMeterList,
  ];
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    _animation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);

    menuBloc = BlocProvider.of<MenuBloc>(context);
    if (mounted) {
      getHandleRole();
    }
  }

  Future getHandleRole() async {
    var storage = LocalStorage(KeyLocalStorageConstants.userDetail);
    role = storage.getItem(KeyLocalStorageConstants.role);
    menuBloc.add(RolesStatus(role: role));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: Key('sidebar_widget'),
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
              )
            ],
            color: Colors.white,
          ),
          width: _animation.value,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    collapsed = !collapsed;
                    // MainPage(isSideBarOpen: true);
                    collapsed
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      // color: Colors.redAccent,
                      height: 60,
                      width: _animation.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'images/Group52.png',
                            color: Grey.brownGrey,  
                            alignment: Alignment.centerRight,
                            height: 52,
                            width: 45,
                          ),
                          SizedBox(
                            width: _animation.value >= 220 ? 20 : 0,
                          ),
                          if (_animation.value >= 220)
                            Padding(
                              padding:  EdgeInsets.only(right:20.0),
                              child: InkWell(
                                child: Text(
                                  'PX Portal',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      color: Colors.black),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 99;
                                  });
                                  locator<NavigationService>()
                                      .navigateTo(Routes.homeScreen);
                                },
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<MenuBloc, MenuState>(
                // bloc: menuBloc,
                builder: (context, state) {
                  if (state is MenuInitial) {}
                  if (state is MenuLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is MenuLoaded) {
                    menuData = state.menurole;
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, counter) {
                          return Divider(
                            height: 10,
                            color: selectedIndex ==counter? Purple.barneyPurple: Grey.brownGrey,
                            thickness: 0.2,
                            endIndent: 10,
                            indent: 10,
                          );
                        },
                        itemCount: menuData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MenuItemTile(
                            title: menuData[index].title,
                            icon: menuData[index].icon,
                            animationController: _animationController,
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                locator<NavigationService>()
                                    .navigateTo(menuData[index].route);
                              });
                            },
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox(height: 0, width: 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

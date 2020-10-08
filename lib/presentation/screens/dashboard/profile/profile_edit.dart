// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:duit_yourself/presentation/screens/dashboard/base_layout.dart';
import 'package:duit_yourself/presentation/screens/dashboard/bloc/app_bar_bloc/app_bar_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:duit_yourself/presentation/screens/dashboard/profile/personal_information_tab.dart';
// import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProfileEdit extends StatefulWidget {
  final String username;
  final ImageProvider image;
  final dynamic arguments;
  final AppBarBloc bloc;
  final DashboardBloc dashboardBloc;

  const ProfileEdit({
    Key key,
    this.username,
    this.image,
    this.arguments,
    this.bloc,
    this.dashboardBloc,
  }) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit>
    with TickerProviderStateMixin {
  TextEditingController nameController;
  TextEditingController selfDescriptionControler;
  TextEditingController headline;
  TabController profileTab;
  bool isPictHovered = false;
  Uint8List uploadedImage;
  String error;
  Image displayedImage;
  File savedImage;
  dynamic base64;

  @override
  void initState() {
    super.initState();
    profileTab = TabController(length: 1, vsync: this);
    widget.bloc.add(GetUserData());
    nameController = TextEditingController();
    selfDescriptionControler = TextEditingController();
    headline = TextEditingController();
    nameController.addListener(() {
      setState(() {});
    });
    selfDescriptionControler.addListener(() {
      setState(() {});
    });
    headline.addListener(() {
      setState(() {});
    });
  }

  void hoverPicture(bool isHovered) {
    setState(() {
      isPictHovered = isHovered;
    });
  }

  void render() {
    setState(() {});
  }

  void startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        print('file $file');

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
            savedImage = files[0];
            displayedImage = Image.memory(
              uploadedImage,
              fit: BoxFit.cover,
              height: 800,
              width: 800,
            );
          });
        });

        print('result ${reader.result}');

        reader.onError.listen((fileEvent) {
          setState(() {
            error = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('IMAGE ${widget.image}');
    return Center(
      child: Container(
        width: 1280,
        constraints: BoxConstraints(minWidth: 600, maxHeight: double.infinity),
        child: BaseLayout(
          arguments: widget.arguments,
          flexLeft: 3,
          flexRight: 1,
          rightColumn: Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                onHover: (e) {
                  hoverPicture(true);
                },
                onExit: (event) {
                  hoverPicture(false);
                },
                child: BlocConsumer<AppBarBloc, AppBarState>(
                    listener: (context, state) {
                  if (state is ProfileSaved) {
                    showToast('Profile Saved',
                        context: context,
                        animation: StyledToastAnimation.fade,
                        curve: Curves.linear,
                        reverseCurve: Curves.linear);
                  }
                }, builder: (context, state) {
                  if (state is GetDataLoading) {
                    return Shimmer(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              displayedImage != null ? null : Color(0xff204c7d),
                        ),
                      ),
                    );
                  }
                  if (state is DataLoaded) {
                    return Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            displayedImage != null ? null : Color(0xff204c7d),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: [
                            displayedImage ??
                                Image(
                                  image: widget.image,
                                  fit: BoxFit.cover,
                                  height: 800,
                                  width: 800,
                                ),
                            if (isPictHovered)
                              GestureDetector(
                                onTap: () {
                                  startFilePicker();
                                },
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        color: Colors.black38,
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.edit,
                                              color: White.white,
                                            ),
                                          ),
                                          Text(
                                            'Change',
                                            style: PxText.contentText.copyWith(
                                                color: White.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }),
              )
            ],
          ),
          leftColumn: Column(
            children: [
              Flexible(
                child: Container(
                  // height: ,
                  // padding: EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(minHeight: 200, maxHeight: 350),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: TabBarView(controller: profileTab, children: [
                    Center(
                        child: BlocConsumer<AppBarBloc, AppBarState>(
                      listener: (context, state) {
                        if (state is DataLoaded) {
                          nameController.text = state.displayName;
                          selfDescriptionControler.text = state.selfDescription;
                          headline.text = state.headline;
                        }
                      },
                      builder: (context, state) {
                        if (state is GetDataLoading) {
                          return PersonalInformation(
                            nameController: nameController,
                            isShimmer: true,
                            render: render,
                            headline: headline,
                            selfDescriptionControler: selfDescriptionControler,
                          );
                        }
                        return PersonalInformation(
                          nameController: nameController,
                          headline: headline,
                          isShimmer: false,
                          render: render,
                          onSave: () {
                            widget.dashboardBloc.add(SaveProfile(
                                profile: savedImage ?? widget.image,
                                selfDescription: selfDescriptionControler.text,
                                username: nameController.text,
                                headline: headline.text));
                          },
                          onCancel: () {
                            widget.dashboardBloc.add(Home());
                          },
                          selfDescriptionControler: selfDescriptionControler,
                        );
                      },
                    )),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

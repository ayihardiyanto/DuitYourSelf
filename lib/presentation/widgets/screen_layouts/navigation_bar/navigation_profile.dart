import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

import 'package:localstorage/localstorage.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';

class NavigationProfile extends StatefulWidget {
  NavigationProfile({Key key}) : super(key: key);

  @override
  _NavigationProfileState createState() => _NavigationProfileState();
}

class _NavigationProfileState extends State<NavigationProfile> {
  String username;
  String photo;
  String role;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
  }

  void getData() async {
    var storage = LocalStorage(KeyLocalStorageConstants.userDetail);
    username = storage.getItem(KeyLocalStorageConstants.username);
    role = storage.getItem(KeyLocalStorageConstants.role);
    photo = storage.getItem(KeyLocalStorageConstants.photo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 5, right: 10),
          child: Container(
            width: 45.0,
            height: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: NetworkImage(photo),
              // ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '',
                style: TextStyle(
                    color: Grey.brownGrey,
                    fontSize: 18,
                    fontFamily: 'TTCommons-medium'),
              ),
              Text(
                '',
                style: TextStyle(
                    color: Grey.brownGrey,
                    fontSize: 14,
                    fontFamily: 'TTCommons-light'),
              )
            ],
          ),
        )
      ],
    ));
  }
}

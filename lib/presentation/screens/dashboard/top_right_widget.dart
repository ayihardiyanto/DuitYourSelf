import 'package:duit_yourself/presentation/screens/dashboard/dashboard_string.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TopRightWidget extends StatelessWidget {
  final bool isInitialUser;
  final String imageUrl;
  final String username;
  final Function onHoverProfile;
  final bool isShimmer;

  const TopRightWidget({
    Key key,
    this.isInitialUser,
    this.imageUrl,
    this.username,
    this.onHoverProfile,
    this.isShimmer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final imageWidth = width * 0.045;
    final imageHeight = height * 0.045;
    final iconSize = height * 0.032;
    final respImageWi = imageWidth < 40 ? 40 : imageWidth;
    final respImageHi = imageHeight < 28 ? 28 : imageHeight;
    final respIcon = iconSize < 25 ? 25 : iconSize;

    print('IMAGE $imageUrl $username');

    return Padding(
      padding: EdgeInsets.only(right: width * 0.05, left: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MouseRegion(
            onHover: (e) {
              onHoverProfile(false);
            },
            child: isShimmer
                ? Container(
                    width: width * 0.091,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        username ?? 'Name',
                        style: PxText.contentText.copyWith(
                            color: Black.lightBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          'Your Headline',
                          style: PxText.contentText.copyWith(
                            color: Blue.lightNavy,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          MouseRegion(
            onHover: (onHover) {
              onHoverProfile(true);
            },
            cursor: SystemMouseCursors.click,
            child: isShimmer
                ? Shimmer(
                    child: Container(
                        width: respImageWi,
                        height: respImageHi,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        )),
                  )
                : Container(
                    width: respImageWi,
                    height: respImageHi,
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
          isShimmer
              ? Container(
                width: width *0.085,
              )
              : Row(
                  children: [
                    MouseRegion(
                      onHover: (e) {
                        onHoverProfile(false);
                      },
                      child: Container(
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            Icons.notifications,
                            size: respIcon,
                            color: Blue.lightNavy,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Blue.lightNavy,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
        ],
      ),
    );
  }
}

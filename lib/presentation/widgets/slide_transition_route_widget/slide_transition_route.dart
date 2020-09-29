import 'package:flutter/material.dart';

///
/// How to Use Slide Route Transition
/// 1 : Go to `Routing.dart`
/// 2 : Go to your own Routes.name Switch Case ex: `case Routes.preboardingTask:`
/// 3 : Change the retrun from `return MaterialPageRoute<dynamic>( . . . . .)`
///      to `return SlideRouteTransition(page : _buildPage, animationTo : animationTo)`
///      ex: `return SlideRouteTransition(page : _buildPreboardingTask(settings.arguments),`
///         ` animationTo : AnimationTo.left)`
///
///  Note : Options of the animation is `{ left , right , top , bottom }`
///  with calling `AnimationTo.left / AnimationTo.right / AnimationTo.top / AnimationTo.bottom`
///

enum AnimationTo { left, right, top, bottom }

class SlideRouteTransition extends PageRouteBuilder {
  final Widget page;

  final AnimationTo animationTo;

  SlideRouteTransition({@required this.page, @required this.animationTo})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: animationTo == AnimationTo.left
                  ? Offset(1, 0)
                  : animationTo == AnimationTo.right
                      ? Offset(-1, 0)
                      : animationTo == AnimationTo.top
                          ? Offset(0, 1)
                          : Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

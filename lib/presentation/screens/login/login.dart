// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:duit_yourself/presentation/screens/login/bloc/authentication/authentication_bloc.dart';
// import 'package:duit_yourself/presentation/screens/login/login_screen.dart';

// import '../../../common/routes/routes.dart';
// import 'validator/show_dialog.dart';
// // import 'package:duit_yourself/presentation/screens/login/validator/show_dialog.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   AuthenticationBloc authenticationBloc;
//   String name;
//   String role;
//   String photo;

//   @override
//   void initState() {
//     super.initState();
//     authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
//     if (mounted) {
//         authenticationBloc.add(AppStarted());
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.white,
//       child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
//           listener: (context, state) {
//         if (state is Unauthorized) {
//           authenticationBloc.add(LoginDenied());
//           showDialogAlert(context);
//         }
//       }, builder: (context, state) {
//         if (state is Uninitialized) {
//           return CircularProgressIndicator();
//         }
//         if (state is Unauthenticated) {
//           Future.delayed(Duration(milliseconds: 100), () {
//             return LoginScreen();
//           });
//         }
//         if (state is Authenticated) {
//           // return HomeScreen(name: state.displayName, photo: state.photo, role: state.role,);
//         //   return BlocProvider<MenuBloc>(
//         //       create: (BuildContext context) => getIt<MenuBloc>(),
//         //       child: MainPage(
//         //           isSideBarOpen: true,
//         //           // payload: {'name': state.displayName,'role': state.role,'photo': state.photo}
//         //           ));
//           Navigator.of(context).pushNamed(Routes.homeScreen);
//         }
//         return LoginScreen();
//       }),
//     ));
//   }
// }

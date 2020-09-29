// import 'package:meta/meta.dart';
// import 'package:injectable/injectable.dart';
// import 'package:dio/dio.dart';
//
// import 'package:duit_yourself/common/network/rest_client.dart';
// import 'package:duit_yourself/data/user/models/user_model.dart';
//
// @Bind.toType(UserRemoteDatasourceImpl)
// @injectable
// abstract class UserRemoteDatasource {
//   Future<User> getUser({@required String email});
// }
//
// @lazySingleton
// @injectable
// class UserRemoteDatasourceImpl implements UserRemoteDatasource {
//   final RestClient client;
//
//   UserRemoteDatasourceImpl({@required this.client});
//
//   @override
//   Future<User> getUser({@required String email}) async {
//     final Response response = await client.get('/hello/$email');
//
//     return User.fromJson(response.data);
//   }
// }

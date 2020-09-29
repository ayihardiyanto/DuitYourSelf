
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

abstract class CloudFunction {
  dynamic triggerFunction(String functionName, Map<String, dynamic> params);
}

@LazySingleton(as: CloudFunction)
class FirebaseFunctionImpl implements CloudFunction {
  @override
  dynamic triggerFunction(
      String functionName, Map<String, dynamic> params) async {
    try {
      HttpsCallable callable = CloudFunctions(region: 'asia-east2')
          .getHttpsCallable(functionName: functionName)
            ..timeout = const Duration(seconds: 60);
      HttpsCallableResult result = await callable.call(params);
      print('result result' + result.toString());
      return result.data;
    } on CloudFunctionsException catch (e) {
      print('Exception Caught By Cloud Function');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('Generic Exception');
      print(e);
    }
  }
}

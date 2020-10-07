import 'package:duit_yourself/presentation/screens/login/login_strings.dart';
import 'package:duit_yourself/presentation/screens/sign_up/sign_up_strings.dart';
import 'package:flutter/material.dart';
void precachedImage(BuildContext context){
    precacheImage(AssetImage(LoginStrings.image1), context);
    precacheImage(AssetImage(LoginStrings.image2), context);
    precacheImage(AssetImage(LoginStrings.image3), context);
    precacheImage(AssetImage(LoginStrings.image4), context);
    precacheImage(AssetImage(SignUpStrings.successImage), context);
    precacheImage(AssetImage(LoginStrings.hazardIcon), context);

}
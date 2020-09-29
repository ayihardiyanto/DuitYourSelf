import 'package:duit_yourself/common/config/screen_config.dart';

extension SizeExtension on num {
  num get w => ScreenConfig().width(this);

  num get h => ScreenConfig().height(this);

  num get sp => ScreenConfig().fontSize(this);

  num get ssp => ScreenConfig().fontSize(this, allowFontScalingSelf: true);
}
import 'package:ti/commonutils/logger.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  final log = getLogger('SizeConfig');
  static double screenWidth = 100;
  static double screenHeight = 100;
  static double blockWidth = 0;
  static double blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;

    textMultiplier = blockHeight;
    imageSizeMultiplier = blockWidth;
    heightMultiplier = blockHeight;
    widthMultiplier = blockWidth;

    log.d('screen width $screenWidth');
    log.d('screen height $screenHeight');
    log.d('block width $blockWidth');
    log.d('block height $blockHeight');
  }
}

import 'package:flutter/material.dart';
import 'colorsConst.dart';
class Dimens {
  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;

  static const double gap_dp5 = 5;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp50 = 50;
}
class TextStyles {

static const TextStyle textSize12 = const TextStyle(
fontSize: Dimens.font_sp12,
);
static const TextStyle textSize16 = const TextStyle(
fontSize: Dimens.font_sp16,
);
static const TextStyle textBold14 = const TextStyle(
fontSize: Dimens.font_sp14,
fontWeight: FontWeight.bold
);
static const TextStyle textBold16 = const TextStyle(
fontSize: Dimens.font_sp16,
fontWeight: FontWeight.bold
);
static const TextStyle textBold18 = const TextStyle(
fontSize: Dimens.font_sp18,
fontWeight: FontWeight.bold
);
static const TextStyle textBold24 = const TextStyle(
fontSize: 24.0,
fontWeight: FontWeight.bold
);
static const TextStyle textBold26 = const TextStyle(
fontSize: 26.0,
fontWeight: FontWeight.bold
);

static const TextStyle textGray14 = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colours.text_gray,
);
static const TextStyle textDarkGray14 = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colours.dark_text_gray,
);

static const TextStyle textWhite14 = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colors.white,
);

static const TextStyle text = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colours.text,
// https://github.com/flutter/flutter/issues/40248
textBaseline: TextBaseline.alphabetic
);
static const TextStyle textDark = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colours.dark_text,
textBaseline: TextBaseline.alphabetic
);

static const TextStyle textGray12 = const TextStyle(
fontSize: Dimens.font_sp12,
color: Colours.text_gray,
fontWeight: FontWeight.normal
);
static const TextStyle textDarkGray12 = const TextStyle(
fontSize: Dimens.font_sp12,
color: Colours.dark_text_gray,
fontWeight: FontWeight.normal
);

static const TextStyle textHint14 = const TextStyle(
fontSize: Dimens.font_sp14,
color: Colours.dark_unselected_item_color
);
}



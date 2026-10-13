import 'package:flutter/material.dart';

extension WidgetExtension on Widget {

  Widget withPadding({ double horizontal=0.0, double vertical=0.0}) {
    return Padding(
      padding: .symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }
  Widget withAllPadding({ double all=0.0}) {
    return Padding(
      padding: .all(all),
      child: this,
    );
  }

    Widget withLeftRightBottomTopPadding({ double left=0.0, double right=0.0, double bottom=0.0, double top=0.0}) {
    return Padding(
      padding: .only(
        left: left,
        right: right,
        bottom: bottom,
        top: top,
      ),
      child: this,
    );
  }
}
      
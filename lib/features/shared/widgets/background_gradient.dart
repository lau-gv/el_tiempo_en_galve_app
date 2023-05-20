import 'package:flutter/material.dart';

import '../../../config/themes/dark_theme.dart';

class BackgroundGradient extends StatelessWidget {

  final Widget? widget;
  
  const BackgroundGradient({
    super.key, this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [DarkTheme.gradientBackgroundColorTop, DarkTheme.gradientBackgroundColorDown]
        )
      ),
      child: widget
    );
  }
}
//import 'package:byb/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:provider/provider.dart';

class SvgIcon extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final bool isAlwaysWhite;
  final Color? fixedColor;

  const SvgIcon(
      {super.key,
      required this.path,
      this.fit = BoxFit.cover,
      this.height,
      this.width,
      this.color,
      this.isAlwaysWhite = false,
      this.fixedColor,});
  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<ThemeProvider>(context);
    // bool isDark =  MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SvgPicture.asset(
      'assets/svgs/$path.svg',
      height: height,
      width: width,
      fit: fit,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              isAlwaysWhite ? Colors.white : fixedColor ?? (Colors.white),
              BlendMode.srcIn,),
    );
  }
}

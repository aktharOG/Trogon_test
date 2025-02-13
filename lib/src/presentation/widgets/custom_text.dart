import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String name;
  final double fontsize;
  final FontWeight fontweight;
  final Color? color;
  final bool align;
  final int? maxlines;
  final TextDirection? textDirection;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;
  final FontStyle? fontStyle;
  final Color? decorationColor;
  const CustomText({
    super.key,
    required this.name,
    this.fontsize = 15,
    this.fontweight = FontWeight.normal,
    this.color,
    this.align = false,
    this.maxlines,
    this.textDirection,
    this.decorationStyle,
    this.decoration,
    this.textAlign,
    this.shadows,
    this.overflow,
    this.fontStyle,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    return Text(
      name,
      style: TextStyle(
      //fontFamily: 'Inter',
      // fontFamily: 'Anek Malayalam',
      
        shadows: shadows,
        fontSize: fontsize,
        fontWeight: fontweight,
        overflow: overflow,
        fontStyle: fontStyle,
        color: color ?? Colors.black,
        decorationStyle: decorationStyle,
        decoration: decoration,
        decorationColor: decorationColor ?? Colors.white,
      ),
      textAlign: textAlign ?? (align ? TextAlign.center : TextAlign.start),
      maxLines: maxlines?? defaultTextStyle.maxLines,
      overflow: overflow,
      textDirection: textDirection,
      
      
    );
  }
}

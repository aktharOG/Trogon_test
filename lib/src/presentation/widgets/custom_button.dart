
import '../../../exports_main.dart';
import '../../core/utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double height;
  final double? width;
  final Color? backgroundColor;
  final bool isGradient;
  final Function()? onPressed;
  final Widget? icon;
  final double fontSize;
  final Color? foregroundColor;
  final double spacing;
  final double elevation;
  final bool isShadow;
  final double radius;
  final Widget? leadingIcon;
  final bool isLoading;
  final List<Shadow>? textShadow;
  final Color? trailingBxColor;
  final bool isOutline;
  final Color? outlineColor;
  final FontWeight? fontweight;
  final BorderRadius? borderRadius;
 final MainAxisAlignment? mainAxisAlignment;
 final bool isExpandTrailingIcon;
 final Color? loadingColor;

  const CustomButton(
      {super.key,
      this.onPressed,
      required this.label,
      this.height = 45,
      this.width,
      this.backgroundColor,
      this.foregroundColor,
      this.isGradient = true,
      this.icon,
      this.spacing = 0,
      this.fontSize = 18,
      this.elevation = 0,
      this.isShadow = false,
      this.radius = 6,
      this.leadingIcon,
      this.isLoading = false,
      this.textShadow,
      this.trailingBxColor,
      this.isOutline = false,
      this.outlineColor,
      this.fontweight,
      this.borderRadius,
      this.mainAxisAlignment,
      this.isExpandTrailingIcon = false,
      this.loadingColor,
      });

  @override
  Widget build(BuildContext context) {
    // final responsive = Responsive(context);
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border:
            isOutline ? Border.all(color: outlineColor ?? Colors.grey) : null,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            elevation: WidgetStateProperty.all(elevation),
            backgroundColor: WidgetStateProperty.all(!isGradient
                ? Colors.transparent
                : backgroundColor ?? AppColors.primary,),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:borderRadius?? BorderRadius.circular(radius),),),),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ?  Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color:loadingColor?? Colors.white,
                  ),
                ),
              )
            : (icon == null && leadingIcon == null
                ? CustomText(
                    name: label,
                    color: foregroundColor ?? Colors.white,
                    fontweight: fontweight ?? FontWeight.w500,
                    fontsize: fontSize,
                    shadows: textShadow,
                  )
                : Row(
                    mainAxisAlignment: mainAxisAlignment?? MainAxisAlignment.center,
                    children: [
                      if (leadingIcon != null) leadingIcon!,
                      SizedBox(width: spacing),
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: fontSize,
                            color: foregroundColor ?? Colors.white,
                            fontWeight: fontweight ?? FontWeight.w500,),
                      ),

                      SizedBox(width: spacing),
                      if(isExpandTrailingIcon)
                     const Spacer(),
                      if (icon != null) icon!,
                    ],
                  )),
      ),
    );
  }
}

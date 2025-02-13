import 'package:cached_network_image/cached_network_image.dart';

import '../../../../exports_main.dart';
import '../../core/utils/app_colors.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.boxFit,
    this.errorIcon = false,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final bool errorIcon;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imagePath,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: !errorIcon
            ? Icon(Icons.error)
            : Icon(
                Icons.person,
                color: Colors.white,
              ),
      ),
    );
  }
}

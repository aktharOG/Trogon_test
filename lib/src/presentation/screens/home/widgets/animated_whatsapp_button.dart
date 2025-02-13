// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:trogon_test/src/presentation/provider/home_provider.dart';

import '../../../../../../exports_main.dart';
import '../../../../core/constants/app_svgs.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_svg_widget.dart';

class WhatsAppButton extends StatefulWidget {
  const WhatsAppButton({super.key});

  @override
  _WhatsAppButtonState createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton>
    with SingleTickerProviderStateMixin {
  bool _showFullButton = true;
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Create AnimationController for bounce effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Define a bounce animation curve
    _bounceAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Start timer to switch button shape and size after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showFullButton = false;
      });
      _controller.forward(); // Trigger bounce animation
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      alignment: _showFullButton
          ? Alignment.bottomRight
          : Alignment.bottomLeft, // Move from right to left
      curve: Curves.easeInOut,
      child: _showFullButton
          ? _buildFullButton()
          : ScaleTransition(
              scale: _bounceAnimation,
              child: _buildIconButton(),
            ),
    );
  }

  Widget _buildFullButton() {
    final homePro = context.read<HomeProvider>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 50, // Size of the button
      width: 200, // Full width
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius:
            BorderRadius.circular(30), // Rounded corners for full button
      ),
      child: CustomButton(
        onPressed: () {
          homePro.onOpenWhatsApp('+919746263704', "Need Assistance");
        },
        spacing: 5,
        elevation: 4,
        radius: 30,
        backgroundColor: AppColors.green,
        leadingIcon: const SvgIcon(path: AppSvgs.whatsappIcon),
        label: "Connect on WhatsApp", // Full text
        fontSize: 12,
      ),
    );
  }

  Widget _buildIconButton() {
    final homePro = context.read<HomeProvider>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 50, // Size of the icon button
      width: 50, // Square for the icon
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(25), // Fully rounded corners
      ),
      child: IconButton(
        onPressed: () {
          homePro.onOpenWhatsApp('+919746263704', "Need Assistance");
        },
        icon: const SvgIcon(path: AppSvgs.whatsappIcon), // Only the icon
      ),
    );
  }
}

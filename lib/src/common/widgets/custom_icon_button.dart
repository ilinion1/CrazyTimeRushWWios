import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';

class CtrCustomIconButton extends StatefulWidget {
  const CtrCustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final String icon;
  final Function()? onPressed;

  @override
  State<CtrCustomIconButton> createState() => _CtrCustomIconButtonState();
}

class _CtrCustomIconButtonState extends State<CtrCustomIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) {
        final model = ZnSettingsProvider.read(context)!.model;
        if (model.sound)
          AudioPlayer().play(AssetSource('audio/sound_default.wav'));
        isPressed = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 150), () {
          isPressed = false;
          setState(() {});
        });
        if (widget.onPressed == null) return;
        widget.onPressed!();
      },
      onPanDown: (_) => setState(() {
        isPressed = true;
      }),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            isPressed
                ? CtrAppImages.iconButtonPressed
                : CtrAppImages.iconButton,
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),
          Image.asset(
            widget.icon,
            width: 38,
            height: 38,
          ),
        ],
      ),
    );
  }
}

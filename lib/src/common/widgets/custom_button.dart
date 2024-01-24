import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';

class CtrCustomButton extends StatefulWidget {
  const CtrCustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonType = 'button',
  });

  final Function()? onPressed;
  final String text;
  final String buttonType;

  @override
  State<CtrCustomButton> createState() => _CtrCustomButtonState();
}

class _CtrCustomButtonState extends State<CtrCustomButton> {
  bool isPressed = false;

  void onPressed() {
    final model = ZnSettingsProvider.read(context)?.model;
    if (model?.sound ?? false) {
      AudioPlayer().play(AssetSource('audio/sound_default.wav'));
    }
    isPressed = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 150), () {
      isPressed = false;
      if (mounted) setState(() {});
    });
    if (widget.onPressed == null) return;
    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (_) => setState(() {
        onPressed();
      }),
      onPanDown: (_) => setState(() {
        isPressed = true;
      }),
      // onTap: () => onPressed(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            switch (widget.buttonType) {
              'daily' => isPressed
                  ? CtrAppImages.dailyButtonPressed
                  : CtrAppImages.dailyButton,
              'level' => isPressed
                  ? CtrAppImages.levelButtonPressed
                  : CtrAppImages.levelButton,
              _ => isPressed ? CtrAppImages.buttonPressed : CtrAppImages.button,
            },
            fit: BoxFit.contain,
            // width: 246.w,
            // height: 44.h,
            width: widget.buttonType == 'daily' ? 276.w : 246.w,
            height: widget.buttonType == 'daily' ? 48.h : 64.h,
          ),
          Text(widget.text,
              style: TextStyle(
                  fontFamily: 'Campton Bold',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1))
        ],
      ),
    );
  }
}

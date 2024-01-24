import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_colors.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/common/widgets/blue_title.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/common/widgets/outline_text.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';

class CtrSettingsPage extends StatelessWidget {
  const CtrSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ZnSettingsProvider.watch(context).model;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CtrAppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 86.h),
              const BlueTitle(title: 'Settings'),
              SizedBox(height: 22.h),
              Container(
                height: 82.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(height: 20.h),
                      Text(
                        'Sounds',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Campton Bold',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 0.83),
                      ),
                      Switch(
                        trackOutlineWidth: const MaterialStatePropertyAll(1),
                        inactiveTrackColor: Colors.transparent,
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: const Color(0x991C0049),
                        activeColor: const Color(0xFFFF00D6),
                        trackOutlineColor: const MaterialStatePropertyAll(
                          Colors.white,
                        ),
                        value: model.sound,
                        onChanged: (value) async {
                          await model.setSound(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 147.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Best score:  ${model.score}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 0.83),
                    ),
                    ResetButton(
                      onPressed: () {},
                      text: 'Reset',
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              const Spacer(),
              CtrCustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Lobby',
              ),
              SizedBox(height: 64.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetButton extends StatefulWidget {
  const ResetButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonType = 'button',
  });

  final Function()? onPressed;
  final String text;
  final String buttonType;

  @override
  State<ResetButton> createState() => _ResetButtonState();
}

class _ResetButtonState extends State<ResetButton> {
  bool isPressed = false;

  void onPressed() {
    final model = ZnSettingsProvider.read(context)?.model;

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
            isPressed ? CtrAppImages.resetBlueButton : CtrAppImages.resetButton,
            fit: BoxFit.contain,
            width: 146.w,
            height: 44.h,
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

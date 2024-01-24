import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';

class BlueLevel extends StatelessWidget {
  final int level;
  const BlueLevel({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          CtrAppImages.blueLevelButton,
          width: 176.w,
          height: 44.h,
          fit: BoxFit.contain,
        ),
        Text(
          "Level $level",
          style: const TextStyle(
              fontFamily: 'Campton Bold',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';

class BlueTitle extends StatelessWidget {
  final String title;
  const BlueTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          CtrAppImages.blueTitle,
          width: 246.w,
          height: 44.h,
          fit: BoxFit.contain,
        ),
        Text(
          title,
          style: TextStyle(
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

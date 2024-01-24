import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';

class CtrCustomAppBar extends StatelessWidget {
  const CtrCustomAppBar({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          CtrAppImages.appBar,
          width: 236.w,
          height: 48.h,
          fit: BoxFit.contain,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 30.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

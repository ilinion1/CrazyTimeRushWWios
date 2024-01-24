import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_colors.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/common/widgets/blue_title.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/common/widgets/money_widget.dart';
import 'package:crazy_time_rush/src/common/widgets/outline_text.dart';
import 'package:crazy_time_rush/src/game/components/card_widget.dart';

class CtrRulesPage extends StatelessWidget {
  const CtrRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // const SizedBox.shrink(),

              SizedBox(height: 86.h),

              const BlueTitle(title: 'Rules'),
              SizedBox(height: 22.h),
              Container(
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: 20.h),
                    Text(
                      'You have to collect pairs of\nelements hidden under the cards',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.25),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          CtrAppImages.diamondRules,
                          width: 75,
                          height: 78,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 23.w),
                        Image.asset(
                          CtrAppImages.diamondRules,
                          width: 75,
                          height: 78,
                          fit: BoxFit.contain,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 131.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: 20.h),
                    Text(
                      'You earn points for every\nsuccessful combination',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.25),
                    ),
                    // SizedBox(height: 24.h),
                    Text(
                      'Score: 50',
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 163.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(height: 20.h),
                    Text(
                      'If you fail, you lose your extra\nhearts. Their offering is limited.\nWhen they run out, the game is over',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          CtrAppImages.rubin,
                          width: 35,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 18),
                        Image.asset(
                          CtrAppImages.rubin,
                          width: 35,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 18),
                        Image.asset(
                          CtrAppImages.rubin,
                          width: 35,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),
              CtrCustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Lobby',
              ),
              const SizedBox(height: 65),
            ],
          ),
        ),
      ),
    );
  }
}

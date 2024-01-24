import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/common/widgets/blue_title.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_icon_button.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';
import 'package:crazy_time_rush/src/game/components/level_page.dart';
import 'package:crazy_time_rush/src/game/components/rules_page.dart';
import 'package:crazy_time_rush/src/game/components/settings_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = ZnSettingsProvider.watch(context).model;
    final difference = model.dateTime.difference(DateTime.now());
    final myDuration = (const Duration(days: 1) + difference);
    final formattedDuration =
        "${myDuration.inHours}:${(myDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(myDuration.inSeconds % 60).toString().padLeft(2, '0')}";

    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CtrAppImages.mainBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CtrCustomIconButton(
                    icon: CtrAppImages.settings,
                    onPressed: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ZnSettingsProvider(
                            model: model,
                            child: const CtrSettingsPage(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 22),
                ],
              ),
              const SizedBox(height: 165),
              CtrCustomButton(
                onPressed: () {
                  if (difference.inDays >= -1) return;
                  showDialog(
                    context: context,
                    builder: (context) => DailyLoginWidget(
                      child: ContentWidget(
                        model: model,
                      ),
                    ),
                  );
                },
                text: (difference.inDays >= -1)
                    ? 'Next Daily Reward in $formattedDuration'
                    : 'Daily Reward',
                buttonType: 'daily',
              ),
              const SizedBox(height: 25),
              CtrCustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ZnSettingsProvider(
                      model: model,
                      child: const CtrLevelMap(),
                    ),
                  ),
                ),
                text: 'Play',
              ),
              const SizedBox(height: 25),
              CtrCustomButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CtrRulesPage(),
                  ),
                ),
                text: 'Rules',
              ),
              const SizedBox(height: 108),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyLoginWidget extends StatelessWidget {
  const DailyLoginWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 170.h),
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: 344.w,
              height: 268.h,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    CtrAppImages.closedLevelDialog,
                    fit: BoxFit.contain,
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: BlueTitle(title: 'Daily reward'),
                      )),
                  // Positioned(
                  //   top: 45.h,
                  //   child: GestureDetector(
                  //     onTap: () => Navigator.pop(context),
                  //     child: Container(
                  //       color: Colors.black.withAlpha(0),
                  //       width: 60.w,
                  //       height: 60.w,
                  //     ),
                  //   ),
                  // ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.model,
  });

  final CtrSettingsController model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.h,
      ),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Text(
              'Open the gift and find out what you won!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Campton Bold',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.33),
            ),
          ),
          SizedBox(height: 29.h),
          GestureDetector(
            onTap: () async {
              await model.setDateTime();
              final rand = Random();
              final number = rand.nextInt(3);
              if (!context.mounted) return;
              Navigator.pop(context);
              if (number == 0) {
                print('lose');
                showDialog(
                  context: context,
                  builder: (context) => const DailyLoginWidget(
                    child: WinOrLoseWidget(
                      text: 'Try again in next time',
                      image: CtrAppImages.openedChest,
                    ),
                  ),
                );
                return;
              }
              showDialog(
                context: context,
                builder: (context) => const DailyLoginWidget(
                  child: WinOrLoseWidget(
                    text: '+20 bonuses',
                    image: CtrAppImages.openedChest,
                  ),
                ),
              );
              await model.setMoney(20);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => Image.asset(
                    CtrAppImages.chest,
                    width: 74.w,
                    height: 85.h,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WinOrLoseWidget extends StatelessWidget {
  const WinOrLoseWidget({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 70.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Campton Bold',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.33),
                ),
                Image.asset(
                  image,
                  width: 206.w,
                  height: 206.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

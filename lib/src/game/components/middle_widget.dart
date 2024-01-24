import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/game/components/levels/level1.dart';
import 'package:crazy_time_rush/src/game/components/levels/level3.dart';
import 'package:crazy_time_rush/src/game/game.dart';

class CtrMiddleWidget extends StatelessWidget {
  const CtrMiddleWidget({
    super.key,
    required this.status,
    required this.type,
    required this.cardFlips,
    required this.isDone,
    required this.success,
    required this.level,
    required this.onTryAgainPressed,
    required this.onItemPressed,
  });

  final CtrGameStatus status;
  final List<int> type;
  final List<bool> cardFlips;
  final List<bool> isDone;
  final bool? success;
  final int level;
  final Function(int) onItemPressed;
  final Function() onTryAgainPressed;

  Widget playingWidget() {
    return switch (level) {
      1 => CtrLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      2 => CtrLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      3 => CtrLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      4 => CtrLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      5 => CtrLevel3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      6 => CtrLevel3(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
      _ => CtrLevel1(
          type: type,
          cardFlips: cardFlips,
          isDone: isDone,
          success: success,
          onItemPressed: (int itemIndex) async =>
              await onItemPressed(itemIndex),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      CtrGameStatus.playing => playingWidget(),
      CtrGameStatus.lose => Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Game Over!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Campton Bold',
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1),
                ),
                const SizedBox(height: 20),
                Text(
                  'Try your luck again!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Campton Bold',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1),
                ),
              ],
            ),
            SizedBox(height: 64.h),
            CtrCustomButton(
              onPressed: onTryAgainPressed,
              text: 'Try again',
            ),
            const SizedBox(height: 22),
          ],
        ),
      CtrGameStatus.won => Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Big win!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Campton Bold',
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'You managed to collect all the pairs!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Campton Bold',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1),
              ),
            ),
            const SizedBox(height: 10),
            CtrCustomButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'To next level',
            ),
            const SizedBox(height: 10),
            CtrCustomButton(
              onPressed: onTryAgainPressed,
              text: 'Restart',
            ),
            const SizedBox(height: 22),
          ],
        ),
    };
  }
}

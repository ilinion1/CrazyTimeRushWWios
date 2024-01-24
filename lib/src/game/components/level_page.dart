import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/common/widgets/blue_title.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';
import 'package:crazy_time_rush/src/game/game.dart';

const colorFilterMatrix = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0
]);

class CtrLevelMap extends StatefulWidget {
  const CtrLevelMap({super.key});

  @override
  State<CtrLevelMap> createState() => _CtrLevelMapState();
}

class _CtrLevelMapState extends State<CtrLevelMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final images = <String>[
      'assets/images/e5.png',
      'assets/images/e11.png',
      'assets/images/e14.png',
      'assets/images/e4.png',
      'assets/images/e7.png',
      'assets/images/e17.png',
    ];
    // final imagesClosed = <String>[
    //   'assets/images/e5.png',
    //   'assets/images/e11_grey.png',
    //   'assets/images/e14_grey.png',
    //   'assets/images/e4_grey.png',
    //   'assets/images/e7_grey.png',
    //   'assets/images/e17_grey.png',
    // ];
    final moneys = <int?>[
      60,
      50,
      80,
      120,
      150,
      220,
    ];
    final level = ZnSettingsProvider.watch(context).model.level;
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CtrAppImages.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 86.h),
                const BlueTitle(title: 'Select level'),
                SizedBox(height: 22.h),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisExtent: 167.h,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 173 / 167,
                    ),
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      if (level > index + 1) {
                        print('skiped');
                        return LevelWidget(
                          type: 'skiped',
                          levelIndex: index + 1,
                          money: moneys[index],
                          currentIndex: level,
                          image: images[index],
                        );
                      } else if (level != index + 1) {
                        print('closed');
                        return LevelWidget(
                          type: 'closed',
                          levelIndex: index + 1,
                          money: moneys[index],
                          currentIndex: level,
                          image: images[index],
                        );
                      }
                      print('opened');
                      return LevelWidget(
                        type: 'opened',
                        levelIndex: index + 1,
                        money: moneys[index],
                        currentIndex: level,
                        image: images[index],
                      );

                      // return LevelWidget(
                      //   index: index,
                      //   level: level,
                      //   images: images,
                      //   moneys: moneys,
                      // );
                    },
                  ),
                ),
                // SizedBox(height: 10.h),
                CtrCustomButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Lobby',
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.type,
    required this.levelIndex,
    required this.money,
    required this.currentIndex,
    required this.image,
  });

  final String type;
  final int levelIndex;
  final int? money;
  final int currentIndex;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final model = ZnSettingsProvider.read(context)!.model;
        if (levelIndex == currentIndex) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ZnSettingsProvider(
                model: model,
                child: CtrMyGame(level: levelIndex),
              ),
            ),
          );
        } else if (levelIndex == currentIndex + 1) {
          showDialog(
            context: context,
            builder: (builder) {
              return CustomAlertDialog(
                image: image,
                type: type,
                levelText: '${currentIndex + 1}',
                amount: money ?? 0,
                model: model,
              );
            },
          );
        }
      },
      child: Container(
        width: 173.w,
        height: 170.h,
        decoration: BoxDecoration(
          color: levelIndex <= currentIndex
              ? const Color(0xFF590000)
              : const Color(0xFF595959),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ColorFiltered(
              colorFilter: levelIndex <= currentIndex
                  ? const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    )
                  : colorFilterMatrix,
              child: CircleAvatar(
                backgroundColor: levelIndex > currentIndex
                    ? const Color(0xff6C6C6C)
                    : const Color(0xffFF0000),
                radius: levelIndex > currentIndex ? 32.w : 50.w,
                child: Image.asset(
                  image,
                  width: levelIndex > currentIndex ? 46.w : 70.w,
                  height: levelIndex > currentIndex ? 56.h : 76.w,

                  // color: Color(0x80808080),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text('Level $levelIndex',
                style: TextStyle(
                    fontFamily: 'Campton Bold',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1)),
            const SizedBox(height: 10),
            Text(
                levelIndex == 1
                    ? 'Free'
                    : type == 'opened' || type == 'skiped'
                        ? 'Open'
                        : '$money points',
                style: TextStyle(
                    fontFamily: 'Campton Bold',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1)),
            if (levelIndex > currentIndex) SizedBox(height: 5.h),
            if (levelIndex > currentIndex)
              GestureDetector(
                onTap: () {
                  final model = ZnSettingsProvider.read(context)!.model;
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return CustomAlertDialog(
                        image: image,
                        type: type,
                        levelText: '${currentIndex + 1}',
                        amount: money ?? 0,
                        model: model,
                      );
                    },
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      CtrAppImages.cardButton,
                      width: 106.w,
                      height: 28.h,
                      fit: BoxFit.contain,
                    ),
                    const Text(
                      'Open',
                      style: TextStyle(
                          fontFamily: 'Campton Bold',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.image,
    required this.type,
    required this.levelText,
    required this.amount,
    required this.model,
  });

  final String image;
  final String type;
  final String levelText;
  final int amount;
  final CtrSettingsController model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 158.h),
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: 332.w,
            height: 234.h,
            child: Stack(
              children: [
                Image.asset(
                  type != 'opened'
                      ? CtrAppImages.closedLevelDialog
                      : CtrAppImages.openedLevelDialog,
                  fit: BoxFit.contain,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: Colors.black.withAlpha(0),
                    width: 60.w,
                    height: 60.w,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: type != 'opened' ? 90.h : 80.h),
                      ColorFiltered(
                        colorFilter: type == 'opened'
                            ? const ColorFilter.mode(
                                Colors.transparent,
                                BlendMode.multiply,
                              )
                            : colorFilterMatrix,
                        child: CircleAvatar(
                          backgroundColor: type != 'opened'
                              ? const Color(0xff6C6C6C)
                              : const Color(0xffFF0000),
                          radius: type != 'opened' ? 32.w : 50.w,
                          child: Image.asset(
                            image,
                            width: type != 'opened' ? 46.w : 70.w,
                            height: type != 'opened' ? 56.h : 76.w,

                            // color: Color(0x80808080),
                          ),
                        ),
                      ),
                      SizedBox(height: type != 'opened' ? 14.h : 7.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70.w),
                        child: Text(
                          'Level $levelText',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Campton Bold',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      if (type != 'opened')
                        Text(
                          '$amount points',
                          style: TextStyle(
                              fontFamily: 'Campton Bold',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1),
                        ),
                      SizedBox(height: type != 'opened' ? 30.h : 5.h),
                      GestureDetector(
                        onTap: () async {
                          if (type == 'opened') {
                            Navigator.pop(context);
                          } else {
                            if (model.money - amount < 0) return;
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                image: image,
                                type: 'opened',
                                levelText: levelText,
                                amount: 0,
                                model: model,
                              ),
                            );
                            await model.setLevel(int.parse(levelText));
                            await model.setMoney(-amount);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              CtrAppImages.cardButton,
                              width: 106.w,
                              height: 30.h,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              type != 'opened' ? 'Open' : 'OK',
                              style: const TextStyle(
                                  fontFamily: 'Campton Bold',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 28.h),
                child: const BlueTitle(title: 'Open level'),
              ))
        ],
      ),
    );
  }
}

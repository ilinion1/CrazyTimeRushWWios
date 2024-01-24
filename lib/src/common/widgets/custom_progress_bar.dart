import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/main.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';
import 'package:crazy_time_rush/src/game/components/main_page.dart';

class CtrMyAnimatedProgressBar extends StatefulWidget {
  const CtrMyAnimatedProgressBar({super.key});

  @override
  State<CtrMyAnimatedProgressBar> createState() =>
      _CtrMyAnimatedProgressBarState();
}

class _CtrMyAnimatedProgressBarState extends State<CtrMyAnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(splashListener);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  void splashListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ZnSettingsProvider(
            model: CtrSettingsController()..initSettings(),
            child: const ZnInitAudio(child: MainPage()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CtrAppImages.splash),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.orange,
                              Colors.deepOrange.shade400,
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: SizedBox(
                            width: double.infinity,
                            height: 30.h,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.green.shade100,
                              color: Color.lerp(
                                Colors.greenAccent.shade100,
                                Colors.green.shade700,
                                _animation.value,
                              ),
                              value: _animation.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

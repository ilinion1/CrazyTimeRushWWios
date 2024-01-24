import 'package:crazy_time_rush/src/common/app_colors.dart';
import 'package:crazy_time_rush/webview_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crazy_time_rush/src/common/app_images.dart';
import 'package:crazy_time_rush/src/common/widgets/custom_button.dart';
import 'package:crazy_time_rush/src/controllers/settings_controller.dart';
import 'package:crazy_time_rush/src/game/components/level_page.dart';
import 'package:crazy_time_rush/src/game/components/main_page.dart';
import 'package:crazy_time_rush/src/game/components/rules_page.dart';
import 'package:crazy_time_rush/src/game/components/settings_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CrazyTimeRush());
}

class CrazyTimeRush extends StatelessWidget {
  const CrazyTimeRush({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(393, 852),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SupportScreen(),
      ),
    );
  }
}

class CTRProgressPage extends StatefulWidget {
  const CTRProgressPage({super.key});

  @override
  State createState() => _MyAnimatedProgressBarState();
}

class _MyAnimatedProgressBarState extends State<CTRProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late CtrSettingsController model;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(_splsg);
    _progressAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_progressController);
    _progressController.forward();
    model = CtrSettingsController();
  }

  void _splsg(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ZnSettingsProvider(
            model: model,
            child: ZnInitAudio(
              child: FutureBuilder(
                future: model.initSettings(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return const CTRPageTest();
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    return const CtrFastSplashScreen();
                  }
                },
              ),
            ),
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
          image: AssetImage(CtrAppImages.mainBackground),
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
                animation: _progressAnimation,
                builder: (context, child) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.w),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF3F0936),
                              Color(0xFF34032D),
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
                                const Color(0xFFA9008E),
                                const Color(0xFF640555),
                                _progressAnimation.value,
                              ),
                              value: _progressAnimation.value,
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

  @override
  void dispose() {
    _progressController.removeStatusListener(_splsg);
    _progressController.dispose();
    super.dispose();
  }
}

class CTRPageTest extends StatefulWidget {
  const CTRPageTest({super.key});

  @override
  State<CTRPageTest> createState() => _CTRPageTestState();
}

class _CTRPageTestState extends State<CTRPageTest> {
  bool blue = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final model = ZnSettingsProvider.watch(context).model;
      final difference = model.dateTime.difference(DateTime.now());
      print(model.dateTime);
      print(difference);
      if (difference.inDays < -1) {
        showDialog(
          context: context,
          builder: (context) => DailyLoginWidget(
            child: ContentWidget(
              model: model,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    blue = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ZnSettingsProvider.watch(context).model;

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
              const SizedBox(height: 179),
              Padding(
                padding: EdgeInsets.only(right: 43.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ZnSettingsProvider(
                              model: model,
                              child: const CtrSettingsPage(),
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        CtrAppImages.settingsButton,
                        width: 60.r,
                        height: 60.r,
                        // fit: BoxFit.fill,
                      )),
                ),
              ),
              SizedBox(height: 70.h),
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
                text: 'New Game',
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
              const SizedBox(height: 89),
            ],
          ),
        ),
      ),
    );
  }
}

class ZnInitAudio extends StatefulWidget {
  const ZnInitAudio({super.key, required this.child});

  final Widget child;

  @override
  State createState() => ZnInitAudioState();
}

class ZnInitAudioState extends State<ZnInitAudio> with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (AppLifecycleState.paused == state) {
      final model = ZnSettingsProvider.read(context)!.model;
      await model.stopAudio();
    } else if (AppLifecycleState.resumed == state) {
      if (ZnSettingsProvider.read(context)!.model.sound) {
        final model = ZnSettingsProvider.read(context)!.model;
        if (model.sound) {
          await model.playAudio();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        final model = ZnSettingsProvider.read(context)!.model;
        await model.stopAudio();
      },
      child: widget.child,
    );
  }
}

class CtrFastSplashScreen extends StatelessWidget {
  const CtrFastSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CtrAppImages.mainBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late WebViewController _webViewController;
  bool visibility = true;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(WebviewConsts.launchUrl),
      )
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print(url);
          },
          onPageFinished: (String url) async {
            print(url);
            if (url.contains(WebviewConsts.checkLetter)) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);
                    return const CTRProgressPage();
                  },
                ),
              );
            } else {
              visibility = false;
              setState(() {});
            }
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColoredBox(
            color: Colors.white,
            child: SafeArea(
              child: WebViewWidget(
                controller: _webViewController,
              ),
            ),
          ),
          if (visibility)
            Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  CtrAppImages.mainBackground,
                  fit: BoxFit.contain,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50.w),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: visibility
          ? null
          : ColoredBox(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async {
                      if (await _webViewController.canGoBack()) {
                        _webViewController.goBack();
                      }
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () async {
                      if (await _webViewController.canGoForward()) {
                        _webViewController.goForward();
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

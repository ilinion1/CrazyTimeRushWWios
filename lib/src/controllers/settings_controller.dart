import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:crazy_time_rush/src/data/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CtrSettingsController extends ChangeNotifier {
  bool sound = false;
  int level = 1;

  // updates
  int money = 0;
  int score = 0;
  DateTime dateTime = DateTime.parse("2012-02-27");

  Future<void> setMoney(int amount) async {
    print('setting money');
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    money += amount;
    print(money);
    notifyListeners();
    await storage.setMoney(money);
  }

  Future<void> setScore(int value) async {
    print('setting score');
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    score = value;
    print(score);
    notifyListeners();
    await storage.setScore(value);
  }

  Future<void> setDateTime() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    dateTime = DateTime.now();
    notifyListeners();
    await storage.setDateTime(dateTime);
  }

  Future<bool> initSettings() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    Map<String, dynamic> data = storage.getSettings();
    if (data['sound'] == null || data['level'] == null) {
      await storage.setSettings(
        sound,
        level,
        dateTime,
        money,
        score,
      );
      data = storage.getSettings();
    }
    print(data);
    sound = data['sound'];
    level = data['level'];
    money = data['money'];
    score = data['score'];
    dateTime = data['date_time'];
    notifyListeners();
    await toggleAudio();
    return true;
  }

  Future<void> setSound(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    sound = value;
    notifyListeners();
    await toggleAudio();
    await storage.setSound(sound);
  }

  Future<void> setLevel(int value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final storage = CtrLocalStorage(sharedPreferences);
    level = value;
    notifyListeners();
    await storage.setLevel(value);
  }

  // Audio Section
  final player = AudioPlayer();

  Future<void> toggleAudio() async {
    if (sound) {
      await playAudio();
    } else {
      await stopAudio();
    }
  }

  Future<void> playAudio() async {
    print('play audio');
    if (player.state == PlayerState.playing) return;
    await player.play(AssetSource('audio/music_default.mp3'), volume: 0.3);
    player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> stopAudio() async {
    await player.pause();
  }
}

class ZnSettingsProvider extends InheritedNotifier {
  final CtrSettingsController model;

  const ZnSettingsProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(
          notifier: model,
        );

  static ZnSettingsProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ZnSettingsProvider>()
        ?.widget;
    return (widget is ZnSettingsProvider) ? widget : null;
  }

  static ZnSettingsProvider watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ZnSettingsProvider>()!;
  }
}

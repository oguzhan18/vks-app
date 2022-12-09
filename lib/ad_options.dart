// ignore_for_file: avoid_print

import 'dart:io';

class AdDefaultOptions {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      print('AdDefaultOptions: bannerAdUnitId isAndroid');
      return 'ca-pub-6267344127589014';
    } else if (Platform.isIOS) {
      print('AdDefaultOptions: bannerAdUnitId isIOS');
      return 'ca-pub-6267344127589014';
    } else {
      throw UnsupportedError('AdDefaultOptions: Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-pub-6267344127589014';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('AdDefaultOptions: Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return '<YOUR_ANDROID_INTERSTITIAL_AD_UNIT_ID>';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_INTERSTITIAL_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('AdDefaultOptions: Unsupported platform');
    }
  }
}

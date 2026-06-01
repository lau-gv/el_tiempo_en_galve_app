import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final AdService _instance = AdService._internal();

  factory AdService() {
    return _instance;
  }

  AdService._internal();

  AppOpenAd? _appOpenAd;
  bool _isLoadingAd = false;
  bool _isShowingAd = false;
  DateTime? _appOpenAdLoadTime;

  static const String _adUnitId = 'ca-app-pub-6647677194026374/5159279751';

  Future<void> loadAppOpenAd({VoidCallback? onAdLoaded}) async {
    if (_isLoadingAd || _appOpenAd != null) return;

    _isLoadingAd = true;

    AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          _appOpenAd = ad;
          _appOpenAdLoadTime = DateTime.now();
          _isLoadingAd = false;

          debugPrint('AppOpenAd loaded successfully');

          onAdLoaded?.call();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isLoadingAd = false;
          debugPrint('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showAppOpenAd() async {
    if (_isShowingAd) return;

    if (_appOpenAd == null) {
      await loadAppOpenAd(
        onAdLoaded: () {
          showAppOpenAd();
        },
      );
      return;
    }

    if (_appOpenAdLoadTime != null &&
        DateTime.now().difference(_appOpenAdLoadTime!).inHours >= 1) {
      _appOpenAd?.dispose();
      _appOpenAd = null;

      await loadAppOpenAd(
        onAdLoaded: () {
          showAppOpenAd();
        },
      );
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('AppOpenAd showed');
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        debugPrint('AppOpenAd failed to show: $error');
        loadAppOpenAd();
      },
    );

    await _appOpenAd!.show();
  }

  void dispose() {
    _appOpenAd?.dispose();
  }
}
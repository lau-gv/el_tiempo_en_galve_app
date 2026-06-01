import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeLoadingAdWidget extends StatefulWidget {
  final String title;
  final String message;

  const NativeLoadingAdWidget({
    super.key,
    this.title = "Estamos cargando los datos",
    this.message =
        "La publicidad nos permite ser gratis y pagar el servidor para mantener viva la app.",
  });

  @override
  State<NativeLoadingAdWidget> createState() => _NativeLoadingAdWidgetState();
}

class _NativeLoadingAdWidgetState extends State<NativeLoadingAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-6647677194026374/2497457391'
      : 'ca-app-pub-6647677194026374/2497457391';

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;

          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('NativeAd failed to load: $error');
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        cornerRadius: 12,
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),

            const SizedBox(height: 16),

            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            if (_nativeAdIsLoaded && _nativeAd != null)
              SizedBox(
                height: 320,
                width: double.infinity,
                child: AdWidget(ad: _nativeAd!),
              ),
          ],
        ),
      ),
    );
  }
}
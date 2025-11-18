import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InlineBannerAdWidget extends StatefulWidget {
  const InlineBannerAdWidget({super.key});

  @override
  State<InlineBannerAdWidget> createState() => _InlineBannerAdWidgetState();
}

class _InlineBannerAdWidgetState extends State<InlineBannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isLoaded = false;
  

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Inline banner failed: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) return const SizedBox(height: 60); // reserve space

    return Center(
      child: SizedBox(
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class InlineBannerAdWidget extends StatefulWidget {
//   const InlineBannerAdWidget({super.key});

//   @override
//   State<InlineBannerAdWidget> createState() => _InlineBannerAdWidgetState();
// }

// class _InlineBannerAdWidgetState extends State<InlineBannerAdWidget> {
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     loadAdaptiveBanner();   // <-- MUST CALL HERE
//   }

//   Future<void> loadAdaptiveBanner() async {
//     final width = MediaQuery.of(context).size.width.toInt();

//     final AnchoredAdaptiveBannerAdSize? adaptiveSize =
//         await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

//     if (adaptiveSize == null) {
//       debugPrint("Adaptive banner returned NULL");
//       return;
//     }

//     _bannerAd = BannerAd(
//       adUnitId: 'ca-app-pub-3940256099942544/9214589741', // Test ID
//       size: adaptiveSize,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           setState(() => _isLoaded = true);
//         },
//         onAdFailedToLoad: (ad, error) {
//           debugPrint("Adaptive Banner failed: $error");
//           ad.dispose();
//         },
//       ),
//     );

//     await _bannerAd!.load();
//   }

//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isLoaded) {
//       return const SizedBox(height: 60); 
//     }

//     return Align(
//       alignment: Alignment.center,
//       child: SizedBox(
//         width: _bannerAd!.size.width.toDouble(),
//         height: _bannerAd!.size.height.toDouble(),
//         child: AdWidget(ad: _bannerAd!),
//       ),
//     );
//   }
// }
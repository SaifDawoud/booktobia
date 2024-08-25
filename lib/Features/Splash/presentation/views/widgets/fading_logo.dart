import 'package:booktobia/core/utils/assets.dart';
import 'package:flutter/cupertino.dart';

class FadingLogo extends StatelessWidget {
  final Animation<double> fadingAnimation;

  const FadingLogo({
    super.key,
    required this.fadingAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: fadingAnimation,
        builder: (context,_) {
          return FadeTransition(
            opacity: fadingAnimation,
            child: Image.asset(
              AssetsData.logo,
              height: 200,
              width: 100,
            ),
          );
        });
  }
}

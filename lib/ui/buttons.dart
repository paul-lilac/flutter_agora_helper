import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../theme/colors.dart' as colors;

class EndCallButton extends StatelessWidget {
  const EndCallButton(
      {super.key,
      required this.onPressed,
      required this.redIcon,
      required this.whiteIcon});

  final VoidCallback onPressed;
  final SvgGenImage redIcon;
  final SvgGenImage whiteIcon;

  @override
  Widget build(BuildContext context) {
    return ThatButton(
      onPressed: onPressed,
      isRed: true,
      redIcon: redIcon,
      whiteIcon: whiteIcon,
      iconHeight: MediaQuery.of(context).size.width * 0.1,
    );
  }
}

class AcceptCallButton extends StatelessWidget {
  const AcceptCallButton(
      {super.key,
      required this.onPressed,
      required this.redIcon,
      required this.whiteIcon});

  final VoidCallback onPressed;
  final SvgGenImage redIcon;
  final SvgGenImage whiteIcon;

  @override
  Widget build(BuildContext context) {
    return ThatButton(
      onPressed: onPressed,
      isRed: false,
      color: colors.green,
      redIcon: redIcon,
      whiteIcon: whiteIcon,
      iconHeight: MediaQuery.of(context).size.width * 0.1,
    );
  }
}

class ThatButton extends StatelessWidget {
  const ThatButton({
    Key? key,
    required this.onPressed,
    required this.isRed,
    this.color,
    required this.redIcon,
    required this.whiteIcon,
    this.iconHeight,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isRed;
  final Color? color;
  final SvgGenImage redIcon;
  final SvgGenImage whiteIcon;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.0125,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor:
              color ?? (isRed ? colors.red : colors.light.withOpacity(0.5)),
          padding: const EdgeInsets.all(12),
        ),
        child: (isRed ? redIcon : whiteIcon).svg(
          color: colors.white,
          height: iconHeight ?? MediaQuery.of(context).size.width * 0.06,
          package: "flutter_agora_helper",
        ),
      ),
    );
  }
}

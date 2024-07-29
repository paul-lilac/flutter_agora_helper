import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agora_helper/gen/assets.gen.dart';
import 'package:gap/gap.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NoVideoView extends StatelessWidget {
  const NoVideoView({
    super.key,
    required this.avatarUrl,
    required this.bgColor,
    required this.name,
  });

  final String avatarUrl;
  final Color bgColor;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.bg.provider(
              package: "flutter_agora_helper",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 1),
                CachedNetworkImage(
                  imageUrl: avatarUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.width * 0.25 + 84,
                    width: MediaQuery.of(context).size.width * 0.25 + 84,
                    padding: const EdgeInsets.all(42.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  errorWidget: (context, url, error) => placeholder(
                    MediaQuery.of(context).size.width * 0.25,
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      placeholder(
                    MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                const Gap(24),
                AutoSizeText(
                  name.trim(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 34.0,
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget placeholder(double width) => Container(
      padding: const EdgeInsets.all(42.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Assets.icons.profileLight2.svg(
          width: width,
          fit: BoxFit.contain,
          color: Colors.black.withOpacity(0.5)),
    );

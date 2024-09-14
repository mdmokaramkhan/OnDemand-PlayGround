import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TileCard extends StatelessWidget {
  const TileCard({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      onTap: () => context.pushNamed(
        '/chat-screen',
        queryParameters: {
          'title': title,
          'icon': 'assets/icons/code.svg',
          'desc': title,
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.gapMedium,
          vertical: AppSizes.gapMedium,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).disabledColor,
              child: SvgPicture.asset('assets/icons/group.svg'),
            ),
            const SizedBox(width: AppSizes.gapSmall),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const Spacer(),
            Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.desc,
    required this.title,
    required this.svgAssetPath,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final String desc;
  final String svgAssetPath;
  final Color? iconColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      onTap: onTap,
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.275,
        padding: const EdgeInsets.all(AppSizes.gapMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: iconColor!.withOpacity(0.15),
              child: SvgPicture.asset(
                svgAssetPath,
                // ignore: deprecated_member_use
                color: iconColor,
              ),
            ),
            const Spacer(),
            Text(
              desc,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

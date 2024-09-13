import 'package:chatbot/providers/theme_provider.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: AppSizes.iconSizeSmall,
            backgroundColor: Theme.of(context).hoverColor,
            foregroundImage: const NetworkImage(Constants.avatarLink),
          ),
        ),
        titleSpacing: 0,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 32,
              // ignore: deprecated_member_use
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          alignment: WrapAlignment.spaceEvenly,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              onTap: () {
                debugPrint('tapped');
              },
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
                      backgroundColor: Colors.deepOrange[50],
                      child: SvgPicture.asset(
                        'assets/icons/code.svg',
                        // ignore: deprecated_member_use
                        color: Colors.deepOrange,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Porgram',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Coding',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(width: AppSizes.marginMedium),
            InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              onTap: () {
                debugPrint('tapped');
              },
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
                      backgroundColor: Colors.blue[50],
                      child: SvgPicture.asset(
                        'assets/icons/paper.svg',
                        // ignore: deprecated_member_use
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Content',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Writing',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(width: AppSizes.marginMedium),
            InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              onTap: () {
                debugPrint('tapped');
              },
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
                      backgroundColor: Colors.green[50],
                      child: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        // ignore: deprecated_member_use
                        color: Colors.green,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Assignment',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Planning',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<ThemeProvider>(
        builder: (context, themeProvide, child) {
          return Switch(
            value: themeProvide.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvide.setThemeMode(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
          );
        },
      ),
    );
  }
}

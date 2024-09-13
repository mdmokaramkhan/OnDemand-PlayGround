import 'package:chatbot/providers/theme_provider.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:chatbot/utils/sizes.dart';
import 'package:chatbot/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        centerTitle: true,
        actions: [
          Consumer<ThemeProvider>(
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
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              children: [
                const Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    FeatureCard(
                      desc: 'Porgram',
                      title: 'Coding',
                      svgAssetPath: 'assets/icons/code.svg',
                      iconColor: Colors.deepOrange,
                    ),
                    FeatureCard(
                      desc: 'Content',
                      title: 'Writing',
                      svgAssetPath: 'assets/icons/paper.svg',
                      iconColor: Colors.blue,
                    ),
                    FeatureCard(
                      desc: 'Assignment',
                      title: 'Planning',
                      svgAssetPath: 'assets/icons/calendar.svg',
                      iconColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      ' Group Prompts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).disabledColor,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.gapMedium),
                const TileCard(title: 'Work', subTitle: '20 chats'),
                const SizedBox(height: AppSizes.gapSmall),
                const TileCard(title: 'Product', subTitle: '9 chats'),
                const SizedBox(height: AppSizes.gapSmall),
                const TileCard(title: 'Content', subTitle: '10 chats'),
                const SizedBox(height: AppSizes.gapMedium),
                Row(
                  children: [
                    Text(
                      'Last Prompts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).disabledColor,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: AppSizes.buttonHeight,
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    elevation: WidgetStatePropertyAll(2.0),
                  ),
                  onPressed: () {
                    context.push('/chat-screen');
                  },
                  child: const Text('Ask Me Anything'),
                ),
              ),
            ),
          ),
        ],
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

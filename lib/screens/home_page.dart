import 'package:chatbot/providers/home_provider.dart';
import 'package:chatbot/providers/theme_provider.dart';
import 'package:chatbot/screens/add_group.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    try {
      List<String> userMessages =
          await ChatService().fetchChatHistory("souvikgupta");
      Provider.of<HomeProvider>(context, listen: false)
          .addChatHistory(userMessages);
    } catch (e) {
      print(e); // Handle errors appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                children: [
                  Wrap(
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
                        onTap: () => context.pushNamed(
                          '/chat-screen',
                          queryParameters: {
                            'title': 'Coding & Technology',
                            'icon': 'assets/icons/code.svg',
                            'desc': 'Porgram',
                            'agentIds': ["plugin-1726271699"].join(',')
                          },
                        ),
                      ),
                      FeatureCard(
                        desc: 'Soft',
                        title: 'Skills',
                        svgAssetPath: 'assets/icons/paper.svg',
                        iconColor: Colors.blue,
                        onTap: () => context.pushNamed(
                          '/chat-screen',
                          queryParameters: {
                            'title': 'Soft Skill',
                            'icon': 'assets/icons/paper.svg',
                            'desc': 'Content',
                            'agentIds': ["plugin-1726276852"].join(',')
                          },
                        ),
                      ),
                      FeatureCard(
                        desc: 'Financial',
                        title: 'Queries',
                        svgAssetPath: 'assets/icons/finance.svg',
                        iconColor: Colors.green,
                        onTap: () => context.pushNamed(
                          '/chat-screen',
                          queryParameters: {
                            'title': 'Financial Queries',
                            'icon': 'assets/icons/calendar.svg',
                            'desc': 'Assignment',
                            'agentIds': ["plugin-1726286452"].join(',')
                          },
                        ),
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
                          onPressed: () {
                            showModalBottomSheet(
                              enableDrag: true,
                              isScrollControlled: true,
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return AddGroupScreen();
                              },
                            );
                          },
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeProvider.groups.isEmpty
                        ? 1
                        : homeProvider.groups.length,
                    itemBuilder: (context, index) {
                      if (homeProvider.groups.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Image.network(
                                Constants.emptyState,
                                height: 140,
                              ),
                              Text(
                                'No Groups Found',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                        );
                      } else {
                        final group = homeProvider.groups[index];
                        return TileCard(
                          title: group.name,
                          subTitle: '${group.chats} Chats',
                        );
                      }
                    },
                  ),
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
                          onPressed: () {
                            setState(() {
                              fetchChatHistory();
                            });
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  homeProvider.chatHistory.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Image.network(
                                Constants.emptyState2,
                                height: 140,
                              ),
                              Text(
                                'No history found',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeProvider.chatHistory.length < 5  ? homeProvider.chatHistory.length : 5,
                          itemBuilder: (context, index) {
                            final userMessage = homeProvider.chatHistory[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.only(top: 5.0),
                              child: ListTile(
                                title: Text(userMessage),
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 40),
                ],
              ),
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
      // floatingActionButton: Consumer<ThemeProvider>(
      //   builder: (context, themeProvide, child) {
      //     return Switch(
      //       value: themeProvide.themeMode == ThemeMode.dark,
      //       onChanged: (value) {
      //         themeProvide.setThemeMode(
      //           value ? ThemeMode.dark : ThemeMode.light,
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

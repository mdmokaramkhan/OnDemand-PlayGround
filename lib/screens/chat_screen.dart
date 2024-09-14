import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:chatbot/providers/chat_provider.dart';
import 'package:chatbot/utils/sizes.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.desc,
    required this.agentIds,
  });

  final String? title;
  final String? icon;
  final String? desc;
  final List<String>? agentIds;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController messageController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // void _copyToClipboard(String text) {
  //   Clipboard.setData(ClipboardData(text: text)).then((_) {
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Copied to clipboard')),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    // Scroll to the bottom when messages change
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'New Chat'),
        centerTitle: true,
        backgroundColor: Theme.of(context).disabledColor,
        actions: [
          IconButton(
            onPressed: () {
              chatProvider.clearMessages();
            },
            icon: const Icon(Icons.clear_all_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];

                // Display spinner for loading state
                if (index == chatProvider.messages.length - 1 &&
                    message.text == '...') {
                  return ListTile(
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinKitThreeBounce(
                              color: Theme.of(context).primaryColor,
                              size: 18.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                // Display Markdown content
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: message.isSentByMe ? 25 : 0,
                            right: message.isSentByMe ? 0 : 25,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: message.isSentByMe
                                ? Colors.blue[900]
                                : Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusLarge),
                          ),
                          child: MarkdownBody(
                            selectable: true,
                            data: message.text,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(
                                color: message.isSentByMe
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              code: TextStyle(
                                color: message.isSentByMe
                                    ? Colors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 2),
                        // if (!message.isSentByMe) // Show copy button only for received messages
                        //   Align(
                        //     alignment: Alignment.bottomLeft,
                        //     child: IconButton(
                        //       icon: Icon(Icons.copy, color: Colors.grey[700]),
                        //       onPressed: () => _copyToClipboard(message.text),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Suggestions Chips
          if (chatProvider.suggestions.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).disabledColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: chatProvider.suggestions.map((suggestion) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(suggestion),
                        selected: false,
                        onSelected: (selected) {
                          if (selected) {
                            messageController.text = suggestion;
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.all(AppSizes.marginMedium),
            padding: const EdgeInsets.all(AppSizes.marginSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(AppSizes.marginMedium),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ask anything',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final messageText = messageController.text;
                    if (messageText.isNotEmpty) {
                      chatProvider.addMessage(
                        Message(
                          text: messageText,
                          isSentByMe: true,
                        ),
                        widget.agentIds,
                      );
                      messageController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

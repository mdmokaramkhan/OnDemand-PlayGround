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
  });

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinKitThreeBounce(
                              color: Colors.grey,
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
                    child: Container(
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
                                : Colors.black,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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

import 'package:chatbot/providers/chat_provider.dart';
import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).disabledColor,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.textsms_sharp))],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: message.isSentByMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isSentByMe ? Colors.white : Colors.black,
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
                          isSentByMe: true, // For simplicity, we assume
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

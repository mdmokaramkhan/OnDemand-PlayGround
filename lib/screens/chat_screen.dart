import 'package:chatbot/utils/sizes.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Theme.of(context).disabledColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return Container();
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
                    decoration: const InputDecoration(
                      hintText: 'Ask anything',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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

import 'package:chatbot/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroupScreen extends StatelessWidget {
  AddGroupScreen({super.key});

  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _chatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _groupNameController,
            decoration: const InputDecoration(
              labelText: 'Group Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _chatsController,
            decoration: const InputDecoration(
              labelText: 'Number of Chats',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final groupName = _groupNameController.text;
              final chats = int.tryParse(_chatsController.text) ?? 0;

              if (groupName.isNotEmpty) {
                final newGroup = Groups(name: groupName, chats: chats);
                context.read<HomeProvider>().addGroup(newGroup);

                // Clear input fields after adding
                _groupNameController.clear();
                _chatsController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Group added successfully!')),
                );
              }
            },
            child: const Text('Add Group'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeProvider>().removeLast();
            },
            child: const Text('Remove Last Group'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeProvider>().clearGroup();
            },
            child: const Text('Clear All Groups'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.groups.length,
                  itemBuilder: (context, index) {
                    final group = provider.groups[index];
                    return ListTile(
                      title: Text(group.name),
                      subtitle: Text('Chats: ${group.chats}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

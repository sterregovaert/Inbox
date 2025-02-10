import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inbox example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 94, 255)),
        useMaterial3: true,
      ),
      home: const InboxPage(title: 'Inbox'),
    );
  }
}

class InboxPage extends StatefulWidget {
  const InboxPage({super.key, required this.title});

  final String title;

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class Message {
  final String sender;
  final String body;
  final DateTime time;

  Message({
    required this.sender,
    required this.body,
    required this.time,
  });
}

class _InboxPageState extends State<InboxPage> {
  var messages = <Message>[];

  void _createMessage() {
    setState(() {
      messages.add(
        Message(
          sender: 'Someone',
          body: 'Message ${messages.length + 1}',
          time: DateTime.now(),
        ),
      );
    });
  }

  void _deleteMessage(int index) {
    setState(() {
      messages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Text(
              widget.title,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Feedback',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.inbox),
            onPressed: () {},
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {});
            },
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
            color: Theme.of(context).colorScheme.onPrimary,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Inbox',
                style: TextStyle(fontSize: 32),
              ),
              IconButton(
                onPressed: () => {_createMessage()},
                icon: Icon(Icons.add),
              ),
            ],
          ),
          Divider(color: const Color.fromARGB(255, 121, 121, 121)),
          if (messages.isEmpty) ...[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'No messages yet',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.mail,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(message.body),
                      subtitle: Text(
                        '${message.time.hour.toString().padLeft(2, '0')}:'
                        '${message.time.minute.toString().padLeft(2, '0')}:'
                        '${message.time.second.toString().padLeft(2, '0')}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () => _deleteMessage(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

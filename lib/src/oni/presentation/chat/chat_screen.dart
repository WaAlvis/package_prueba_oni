import 'package:flutter/material.dart';
import 'package:oni_chat_package/src/oni/presentation/providers/chat_provider.dart';
import 'package:oni_chat_package/src/oni/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const name = 'chat-screen';

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(),
        body: const ChatView(),
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: chatProvider.messageList.isEmpty
                  ? const EmptyChatOni()
                  : const ChatListOni(),
            ),
            const SizedBox(
              height: 40,
            ),

            /// Caja de texto de mensajes
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}

class EmptyChatOni extends StatelessWidget {
  const EmptyChatOni({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.asset('assets/images/oni.gif'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Hi I\'m ONI!\nHow can I help you today?',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: _SectionRelevantTopics(),
        )
      ],
    );
  }
}

class _SectionRelevantTopics extends StatelessWidget {
  const _SectionRelevantTopics();

  @override
  Widget build(BuildContext context) {
    final List<String> relevantTopics = [
      'what are the minimum requirements for approvals of house exterior paint?',
      'What are the main function of the architectural control committe?',
      'What are the latest events of the association?',
    ];

    return Wrap(
      children: relevantTopics.map((e) => _TopicKeyButton(e)).toList(),
    );
  }
}

class _TopicKeyButton extends StatelessWidget {
  const _TopicKeyButton(this.questionText);

  final String questionText;

  @override
  Widget build(BuildContext context) {
    final outlineStyle = OutlinedButton.styleFrom(
      fixedSize: const Size(500, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );

    return Container(
      margin: const EdgeInsets.all(4),
      child: OutlinedButton(
        style: outlineStyle,
        onPressed: () => context.read<ChatProvider>().sendMessage(questionText),
        child: Text(
          questionText,
          textAlign: TextAlign.start,
          // style: textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class ChatListOni extends StatelessWidget {
  const ChatListOni({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return ListView.builder(
      shrinkWrap: true,
      controller: chatProvider.chatScrollController,
      itemCount: chatProvider.messageList.length,
      itemBuilder: (_, int index) {
        final message = chatProvider.messageList[index];

        return MessageBubble(
          fromWho: message.fromWho,
          message: message.text,
          indexMsj: index,
        );
      },
    );
  }
}

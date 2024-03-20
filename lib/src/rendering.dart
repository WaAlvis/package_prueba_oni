part of oni_chat;

class ChatOni extends StatelessWidget {
  const ChatOni({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRepositoryImpl =
        ChatRepositoryImpl(chatMessageDatasource: ChatMessageApiDatasource());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => ChatProvider(chatRepositoryImpl: chatRepositoryImpl)
            ..newSessionChat(),
        )
      ],
      child: const ChatView(),
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

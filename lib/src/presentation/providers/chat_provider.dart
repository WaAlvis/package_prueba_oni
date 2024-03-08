import 'package:flutter/material.dart';
import 'package:oni_chat_package/src/infrastructure/repositories/chat_repository_impl.dart';

import '../../domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepositoryImpl chatRepositoryImpl;
  bool isLoading = false;

  ChatProvider({
    required this.chatRepositoryImpl,
  });

  final chatScrollController = ScrollController();

  List<Message> messageList = [];

  Future<void> newSessionChat() async {
    // get ids Sessions (assistant and thread)
    await chatRepositoryImpl.startSessionChat();
  }

  void newChatOni() async {
    isLoading = false;
    messageList.clear();
    newSessionChat();
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.user);
    messageList.add(newMessage);

    oniReply(text);

    notifyListeners();
    // moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> oniReply(String question) async {
    isLoading = true;

    final loadingMsgOni = Message(text: '...', fromWho: FromWho.oni);
    messageList.add(loadingMsgOni);

    moveScrollToBottom();
    notifyListeners();

    final Message newMessageOni = await chatRepositoryImpl.getMessage(question);
    print('*** Se obtuvo respuesta de ONI ***');

    // Validación para el primer mensaje después del reinicio del Chat
    if (messageList.length >= 2) {
      messageList.removeLast(); // Remove the loading ONI
      messageList.add(newMessageOni);
      moveScrollToBottom();
    }

    isLoading = false;

    notifyListeners();
  }
}

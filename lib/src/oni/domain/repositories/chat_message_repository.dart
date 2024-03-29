import 'package:oni_chat_package/src/oni/domain/entities/message.dart';
import 'package:oni_chat_package/src/oni/domain/entities/session_thread.dart';

abstract class ChatMessageRepository {
  Future<Message> getMessage(String question);
  Future<SessionThread> startSessionChat();
}

import 'package:oni_chat_package/src/oni/domain/datasources/chat_message_datasource.dart';
import 'package:oni_chat_package/src/oni/domain/entities/message.dart';
import 'package:oni_chat_package/src/oni/domain/entities/session_thread.dart';
import 'package:oni_chat_package/src/oni/domain/repositories/chat_message_repository.dart';

class ChatRepositoryImpl extends ChatMessageRepository {
  final ChatMessageDatasource chatMessageDatasource;

  ChatRepositoryImpl({
    required this.chatMessageDatasource,
  });

  @override
  Future<Message> getMessage(String question) {
    return chatMessageDatasource.getMessage(question);
  }

  @override
  Future<SessionThread> startSessionChat() {
    return chatMessageDatasource.startSessionChat();
  }
}

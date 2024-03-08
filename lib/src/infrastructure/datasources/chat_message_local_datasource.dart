// Implementación de Base de Datos Local
import 'package:oni_chat_package/src/domain/datasources/chat_message_datasource.dart';
import 'package:oni_chat_package/src/domain/entities/chat_interaction.dart';
import 'package:oni_chat_package/src/domain/entities/message.dart';
import 'package:oni_chat_package/src/domain/entities/session_thread.dart';

class ChatMessageLocalDatasource implements ChatMessageDatasource {
  @override
  Future<SessionThread> startSessionChat() {
    return Future(
        () => SessionThread(assistantId: 'assistantId', threadId: 'threadId'));
  }

  @override
  Future<Message> getMessage(String question) {
    return Future(() => Message(text: 'text', fromWho: FromWho.oni));
  }

  @override
  Future<ChatInteraction> regenerateResponse(String interactionId) {
    return Future(() => ChatInteraction(answers: ['hi'], question: 'Question'));
  }
}

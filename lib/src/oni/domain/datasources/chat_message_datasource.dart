import 'package:oni_chat_package/src/oni/domain/entities/entities.dart';


abstract class ChatMessageDatasource {
  Future<Message> getMessage(String question);
  Future<SessionThread> startSessionChat();
  Future<ChatInteraction> regenerateResponse(String interactionId);
}
import 'package:oni_chat_package/src/domain/entities/entities.dart';

abstract class ChatRepository {
  Future<ChatInteraction> regenerateResponse(String interactionId);
  
}

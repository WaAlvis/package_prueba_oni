import 'package:oni_chat_package/src/oni/domain/entities/message.dart';

class MessageOni {
  static Message messageToEntity(String message) =>
      Message(text: message, fromWho: FromWho.oni);
}

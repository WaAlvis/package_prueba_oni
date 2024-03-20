import 'package:oni_chat_package/src/oni/domain/entities/session_thread.dart';
import 'package:oni_chat_package/src/oni/infrastructure/models/onrDB/session_onr.dart';

class SessionMapper {
  static SessionThread sessionToEntity(SessionOnr session) => SessionThread(
        assistantId: session.assistantId,
        threadId: session.threadId,
      );
}

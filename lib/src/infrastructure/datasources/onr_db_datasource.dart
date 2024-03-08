import 'package:dio/dio.dart';
import 'package:oni_chat_package/src/domain/datasources/chat_message_datasource.dart';
import 'package:oni_chat_package/src/domain/entities/chat_interaction.dart';
import 'package:oni_chat_package/src/domain/entities/message.dart';
import 'package:oni_chat_package/src/domain/entities/session_thread.dart';
import 'package:oni_chat_package/src/infrastructure/mappers/message_oni.dart';
import 'package:oni_chat_package/src/infrastructure/mappers/session_mapper.dart';
import 'package:oni_chat_package/src/infrastructure/models/onrDB/session_onr.dart';

class ChatMessageApiDatasource extends ChatMessageDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000/api/v1', // local
    // baseUrl: 'http://aws-oni-back-dev-env.eba-q6pdvkec.us-east-1.elasticbeanstalk.com/api/v1',
  ));

  final String assistantId = 'asst_xsWGv7zVctrFJLoefNxfu82l';
  late SessionOnr session;

  @override
  Future<Message> getMessage(String question) async {
    Map<String, dynamic> cuerpo = {"userMessage": question};
    print('*****   Esperando respuesta de ONI   *****');
    try {
      final response = await dio.post(
        '/assistant/runAssistant/${session.assistantId}/${session.threadId}',
        data: cuerpo,
      );

      if (response.statusCode == 200) {
        print('*****   Recibida respuesta Exitosa de ONI   *****');
        return MessageOni.messageToEntity(response.data);
      } else {
        // Manejo de otros códigos de estado no esperados
        throw Exception(
            'Unexpected error with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Manejo de errores específicos de Dio
      print(e);
      rethrow;
    } catch (e) {
      // Manejo de otros errores
      print(e);
      rethrow;
    }
  }

  @override
  Future<SessionThread> startSessionChat() async {
    try {
      final response = await dio.post('/assistant/createSession/$assistantId');

      if (response.statusCode == 200) {
        session = SessionOnr.fromJson(response.data);
        // print('Session: ${session.threadId}');
        return SessionMapper.sessionToEntity(session);
      } else {
        // Manejo de otros códigos de estado no esperados
        throw Exception(
            'Unexpected error with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Manejo de errores específicos de Dio
      print(e);
      rethrow; // O manejarlo de otra manera
      // Manejo de errores específicos de Dio
    } catch (e) {
// Manejo de otros errores
      print(e);
      rethrow; // O manejarlo de otra manera
    }
  }

  @override
  Future<ChatInteraction> regenerateResponse(String interactionId) {
    // TODO: implement regenerateResponse
    throw UnimplementedError();
  }
}

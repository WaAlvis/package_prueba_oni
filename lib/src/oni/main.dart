import 'package:flutter/material.dart';
import 'package:oni_chat_package/src/oni/infrastructure/datasources/onr_db_datasource.dart';
import 'package:oni_chat_package/src/oni/infrastructure/repositories/chat_repository_impl.dart';
import 'package:oni_chat_package/src/oni/presentation/chat/chat_screen.dart';
import 'package:oni_chat_package/src/oni/presentation/providers/chat_provider.dart';
import 'package:provider/provider.dart';

import 'config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRepositoryImpl =
        ChatRepositoryImpl(chatMessageDatasource: ChatMessageApiDatasource());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => ChatProvider(chatRepositoryImpl: chatRepositoryImpl)..newSessionChat(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ONI chat',
        theme: AppTheme().theme(),
        home: const ChatScreen(),
      ),
    );
  }
}

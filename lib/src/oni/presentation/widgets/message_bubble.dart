import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oni_chat_package/src/oni/domain/entities/message.dart';
import 'package:oni_chat_package/src/oni/presentation/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final FromWho fromWho;
  final String message;
  final int indexMsj;

  const MessageBubble(
      {super.key,
      required this.fromWho,
      required this.message,
      required this.indexMsj});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chatProvider = context.watch<ChatProvider>();
    final isLastResponse = chatProvider.messageList.length - 1 == indexMsj;

    bool showActionsMsg() {
      return fromWho == FromWho.oni &&
          (!isLastResponse || !chatProvider.isLoading);
    }

    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: (size.width > 1080) ? 150 : 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: ClipOval(
              child: (fromWho == FromWho.user)
                  ? Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOYjs3zDA9mA1DqDKDch1DPuTDBG87OuAKhgMYrN_dxqBQ8PZAu2ehyPjUnzevS96X120&usqp=CAU',
                    )
                  : Image.asset(
                      isLastResponse
                          ? 'assets/images/oni.gif'
                          : 'assets/images/static_oni.gif',
                    ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FromWho.user == fromWho ? 'You' : 'ONI',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  message,
                  style: const TextStyle(fontSize: 12, height: 2),
                ),
                if (showActionsMsg())
                  _ActionsMessage(
                    textToCopy: message,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ActionsMessage extends StatelessWidget {
  const _ActionsMessage({
    required this.textToCopy,
  });
  final String textToCopy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            copiarAlPortapapeles(textToCopy);
          },
          icon: const Icon(Icons.paste_outlined),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.replay)),
      ],
    );
  }

  void copiarAlPortapapeles(String textoACopiar) {
    Clipboard.setData(ClipboardData(text: textoACopiar));
    // Opcional: Mostrar un snackbar o algún feedback al usuario
  }
}

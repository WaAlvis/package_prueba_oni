import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';

class MessageFieldBox extends StatefulWidget {
  const MessageFieldBox({super.key});

  @override
  State<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends State<MessageFieldBox> {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Message ONI...',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      fillColor: focusNode.hasFocus
          ? const Color(0xff1d1d1d)
          : const Color(0xff707070),
      suffixIcon: SendIcon(
        focusNode: focusNode,
        textController: textController,
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      textInputAction: TextInputAction.send,
      decoration: inputDecoration,
      onFieldSubmitted: chatProvider.isLoading
          ? (_) => focusNode.requestFocus()
          : (value) {
              print('Submit value $value');
              chatProvider.sendMessage(value);
              focusNode.requestFocus();
              textController.clear();
            },
    );
  }
}

class SendIcon extends StatelessWidget {
  const SendIcon({
    super.key,
    required this.focusNode,
    required this.textController,
  });

  final FocusNode focusNode;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 4),
      child: FloatingActionButton.small(
        backgroundColor: !chatProvider.isLoading && focusNode.hasFocus
            ? const Color(0xfffcc755)
            : const Color(0xff313131),
        foregroundColor: const Color(0xff1d1d1d),
        onPressed: chatProvider.isLoading
            ? null
            : () {
                final textValue = textController.value.text;
                print('button: $textValue');
                chatProvider.sendMessage(textValue);
                textController.clear();
              },
        child: const Icon(Icons.arrow_upward_outlined),
      ),
    );
  }
}

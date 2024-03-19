class ChatInteraction {
  String question;
  List<String> answers;

  ChatInteraction({required this.question, required this.answers});

  void addAnswer(String answer) {
    answers.add(answer);
  }
}

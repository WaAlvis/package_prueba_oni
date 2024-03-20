class SessionOnr {
  final String assistantId;
  final String threadId;

  SessionOnr({
    required this.assistantId,
    required this.threadId,
  });

  factory SessionOnr.fromJson(Map<String, dynamic> json) => SessionOnr(
        assistantId: json["assistantId"],
        threadId: json["threadId"],
      );

  Map<String, dynamic> toJson() => {
        "assistantId": assistantId,
        "threadId": threadId,
      };
}

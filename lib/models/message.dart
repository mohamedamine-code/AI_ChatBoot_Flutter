class message{
  final String Content;
  final bool isUser;
  final DateTime time;
  final String id;

  message({
    required this.Content,
    required this.id,
    required this.isUser,
    required this.time,
  });
}
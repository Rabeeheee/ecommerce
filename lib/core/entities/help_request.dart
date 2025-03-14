class HelpRequest {
  final String userID;
  final String requestID;
  final String email;
  final String name;
  final DateTime dateTime;
  final String subject;
  final String body;
  final String? answer;

  HelpRequest({
    required this.userID,
    required this.email,
    required this.requestID,
    required this.name,
    required this.dateTime,
    required this.subject,
    required this.body,
    this.answer,
  });
}

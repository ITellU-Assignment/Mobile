class Invite {
  final int id;
  final String teacherName;
  final String studentName;
  final DateTime scheduledAt;
  final String status;

  Invite({
    required this.id,
    required this.teacherName,
    required this.studentName,
    required this.scheduledAt,
    required this.status,
  });

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      id: json['id'] as int,
      teacherName: json['teacher']['name'] as String,
      studentName: json['student']['name'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      status: json['status'] as String,
    );
  }
}

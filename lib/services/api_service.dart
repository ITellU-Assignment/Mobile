import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/invite.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:5000';

  /// Fetch only pending invites for the student
  Future<List<Invite>> fetchPendingInvites() async {
    final uri = Uri.parse('$_baseUrl/invites?status=pending');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load invites (status ${res.statusCode})');
    }
    final List data = json.decode(res.body) as List;
    return data
        .map((e) => Invite.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Accept or reject an invite by ID
  Future<void> updateInviteStatus(int id, String status) async {
    final uri = Uri.parse('$_baseUrl/invites/$id');
    final res = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );
    if (res.statusCode != 200) {
      throw Exception(
          'Failed to update invite (status ${res.statusCode})');
    }
  }
}

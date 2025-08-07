// lib/main.dart

import 'package:flutter/material.dart';
import 'models/invite.dart';
import 'services/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTellU Student',
      theme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.tealAccent,
            ),
      ),
      home: InviteListScreen(),
    );
  }
}

class InviteListScreen extends StatefulWidget {
  const InviteListScreen({super.key});

  @override
  _InviteListScreenState createState() => _InviteListScreenState();
}

class _InviteListScreenState extends State<InviteListScreen> {
  final ApiService _api = ApiService();
  late Future<List<Invite>> _futureInvites;

  @override
  void initState() {
    super.initState();
    _loadInvites();
  }

  void _loadInvites() {
    _futureInvites = _api.fetchPendingInvites();
  }

  Future<void> _respond(Invite invite, String status) async {
    try {
      await _api.updateInviteStatus(invite.id, status);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invite $status')),
      );
      _loadInvites();
      setState(() {}); // trigger rebuild to refresh list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Invites'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _loadInvites();
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Invite>>(
        future: _futureInvites,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load invites'));
          }
          final invites = snapshot.data!;
          if (invites.isEmpty) {
            return Center(child: Text('No pending invites'));
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: invites.length,
            itemBuilder: (context, index) {
              final inv = invites[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(inv.teacherName),
                  subtitle: Text(
                    '${inv.studentName} · ${inv.scheduledAt.toLocal()}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => _respond(inv, 'accepted'),
                        child: Text('Accept'),
                      ),
                      TextButton(
                        onPressed: () => _respond(inv, 'rejected'),
                        child: Text('Reject'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

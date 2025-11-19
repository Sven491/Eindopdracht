// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SupabaseClient supabase;
  String? userId;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    userId = user?.id;
    userEmail = user?.email;
  }

  Future<void> clearWatchlist() async {
    if (userId == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        title: const Text("Bevestiging", style: TextStyle(color: Colors.white)),
        content: const Text("Weet je zeker dat je je hele watchlist wilt verwijderen?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuleer"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Verwijder", style: TextStyle(color: Color(0xFFe57373))),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await supabase.from('watchlist').delete().eq('user_id', userId!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Watchlist is geleegd"),
          backgroundColor: Color(0xFF81C784),
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: const Color(0xFF2C2C54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF5E3A86),
                child: Text(
                  userEmail != null && userEmail!.isNotEmpty ? userEmail![0].toUpperCase() : "?",
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              if (userEmail != null)
                Text(
                  userEmail!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
                ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: clearWatchlist,
                icon: const Icon(Icons.delete_forever),
                label: const Text("Leeg Watchlist"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5E3C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Let op: deze acties zijn permanent en kunnen niet ongedaan worden gemaakt!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

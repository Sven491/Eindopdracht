// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:MovieList/pages/loginpage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SupabaseClient supabase;
  String? userId;
  String? userEmail;
  String? displayName;
  bool useDarkTheme = true;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    userId = user?.id;
    userEmail = user?.email;

    displayName = user?.userMetadata?['display_name'] as String? ?? '';
  }

  //bevesteging verwijder en loguit
  Future<bool?> _confirmDialog(String title, String message, {String confirmText = "Delete"}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2C),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText, style: const TextStyle(color: Color(0xFFe57373))),
          ),
        ],
      ),
    );
  }

  // Watchlist legen
  Future<void> _clearWatchlist() async {
    if (userId == null) return;
    final confirmed = await _confirmDialog("Empty watchlist", "do you really want to empty your watchlist?", confirmText: "Empty");
    if (confirmed != true) return;

    setState(() => isProcessing = true);
    try {
      await supabase.from('watchlist').delete().eq('user_id', userId!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Watchlist emptied"), backgroundColor: Color(0xFF81C784), duration: Duration(seconds: 2)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("error whilst emptying: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  //
  Future<void> _deleteAccountClientSide() async {
    if (userId == null) return;
    final confirmed = await _confirmDialog(
      "Delete accountdata",
      "Deletes all data, your watchlist en logs you out. Your account itself won't be removed completely, and will remain on the server.",
      confirmText: "Delete",
    );
    if (confirmed != true) return;

    setState(() => isProcessing = true);
    try {
      await supabase.from('watchlist').delete().eq('user_id', userId!);
      await supabase.auth.signOut();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Accountdata removed and logged out"), backgroundColor: Colors.red, duration: Duration(seconds: 2)),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error whilst removing: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  Future<void> _signOut() async {
    await supabase.auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }


  Widget _buildActionTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, Color? iconColor}) {
    return Card(
      color: const Color(0xFF1C1C2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor ?? const Color(0xFF5E3A86),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initials = (userEmail != null && userEmail!.isNotEmpty) ? userEmail![0].toUpperCase() : '?';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1C1C2E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF15151B),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 6, offset: Offset(0, 3))],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: const Color(0xFF5E3A86),
                    child: Text(initials, style: const TextStyle(fontSize: 28, color: Colors.white)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(displayName != null && displayName!.isNotEmpty ? displayName! : (userEmail ?? 'Gebruiker'),
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(userEmail ?? '-', style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: _signOut,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white12),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Logout"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            _buildActionTile(
              icon: Icons.delete_outline,
              iconColor: const Color(0xFF8B5E3C),
              title: "Empty watchlist",
              subtitle: "Remove all items from your watchlist",
              onTap: _clearWatchlist,
            ),

            const SizedBox(height: 8),

            _buildActionTile(
              icon: Icons.account_circle_outlined,
              iconColor: const Color(0xFFe57373),
              title: "Delete accountdata",
              subtitle: "Delete accountdata and logout",
              onTap: _deleteAccountClientSide,
            ),

            const SizedBox(height: 18),

            Card(
              color: const Color(0xFF15151B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.white70),
                        SizedBox(width: 8),
                        Expanded(child: Text("About MovieLovr", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Versie: 1.0.0",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "MovieLovr is dé watchlist-app voor filmliefhebbers. Voeg je favoriete films toe, beheer je watchlist, en ontdek nieuwe titels om van te genieten.",
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
            if (isProcessing) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

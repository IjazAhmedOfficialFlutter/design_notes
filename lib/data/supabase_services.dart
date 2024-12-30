import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseService {
  final SupabaseClient supaBase;

  SupaBaseService(this.supaBase);

  Future<List<dynamic>> fetchNotes() async {
    final response = await supaBase
        .from('notes')
        .select()
        .order('created_at', ascending: false);
    return response;
  }

  Future<void> addNote(String title, String body) async {
    await supaBase.from('notes').insert({
      'title': title,
      'body': body,
    });
  }

  Future<void> deleteNote(int id) async {
    await supaBase.from('notes').delete().eq('id', id);
  }

  Future<void> editNote(int id, String title, String body) async {
    await supaBase.from('notes').update({
      'title': title,
      'body': body,
    }).eq('id', id);
  }
}

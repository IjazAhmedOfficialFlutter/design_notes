import 'package:design_notes/global_widgets/text_field_widget.dart';
import 'package:design_notes/utilities/app_text_styles_poppins.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  List<dynamic> notes = [];

  final SupabaseClient supaBase = Supabase.instance.client;

  Future<void> fetchNotes() async {
    final response = await supaBase
        .from('notes')
        .select()
        .order('created_at', ascending: false);
    setState(() {
      notes = response;
    });
  }

  Future<void> addNote() async {
    if (titleController.text.isEmpty || textController.text.isEmpty) {
      return;
    }
    await supaBase.from('notes').insert({
      'title': titleController.text,
      'body': textController.text,
    });
    titleController.clear();
    textController.clear();
    fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await supaBase.from('notes').delete().eq('id', id);
    fetchNotes();
  }

  Future<void> editNotes(int id) async {
    await supaBase.from('notes').update({
      "title":titleController.text,
      "body":textController.text
      
    }).eq("id", id);
    
    fetchNotes();
  }
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }
  showDialogBox() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("title"),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    textFieldColor: Colors.grey,
                    maxLines: 1,
                    textFieldController: titleController,
                    hintText: "title",
                    obscureText: false),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    addNote();
                  },
                  child: Text("Save"))
            ],
            content: TextFieldWidget(
                textFieldColor: Colors.grey,
                maxLines: 4,
                textFieldController: textController,
                hintText: "notes",
                obscureText: false)));
  }
  showDialogBoxEdit({required String title, required String content, int ?id}) async {
    
    titleController.text=title;
    textController.text=content;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("title"),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                    textFieldColor: Colors.grey,
                    maxLines: 1,
                    textFieldController: titleController,
                    hintText: "title",
                    obscureText: false),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                   editNotes(id!);
                  },
                  child: Text("update"))
            ],
            content: TextFieldWidget(
                textFieldColor: Colors.grey,
                maxLines: 4,
                textFieldController: textController,
                hintText: "notes",
                obscureText: false)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            await showDialogBox();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),

            Text("Add short Notes", style: twenty600TextStyle(color: Colors.black),),

            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(note['title'].toString()),
                      subtitle: Text(note['body'].toString()),
                      trailing: SizedBox(
                        width: 100, // Adjust width to fit your icons comfortably
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.penToSquare, color: Colors.red),
                              onPressed: () => showDialogBoxEdit(
                                title: note['title'].toString(),
                                content: note['body'].toString(),
                                id: note['id']
                              ),
                            ),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.trash, color: Colors.red),
                              onPressed: () => deleteNote(note['id']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}

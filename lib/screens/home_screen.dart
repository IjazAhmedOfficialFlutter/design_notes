import 'package:design_notes/global_widgets/text_field_widget.dart';
import 'package:design_notes/utilities/app_text_styles_poppins.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  final titleController = TextEditingController();
  final SupaBaseService supaBaseData = SupaBaseService(Supabase.instance.client);

  List<dynamic> notes = [];

  Future<void> fetchNotes() async {
    final response = await supaBaseData.fetchNotes();
    setState(() {
      notes = response;
    });
  }

  Future<void> addNote() async {
    if (titleController.text.isEmpty || textController.text.isEmpty) {
      return;
    }
    await supaBaseData.addNote(
      titleController.text,
      textController.text,
    );
    titleController.clear();
    textController.clear();
    fetchNotes();
  }

  Future<void> deleteNoteHandler(int id) async {
    await supaBaseData.deleteNote(id);
    fetchNotes();
  }

  Future<void> editNoteHandler(int id) async {
    await supaBaseData.editNote(
      id,
      titleController.text,
      textController.text,
    );
    fetchNotes();
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> showDialogBox() async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Note",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                textStyle: fourteen400TextStyle(color: Colors.black),
                textFieldColor: Colors.white.withOpacity(0.9),
                maxLines: 1,
                textFieldController: titleController,
                hintText: "Enter title",

                obscureText: false,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                textStyle: fourteen400TextStyle(color: Colors.black),

                textFieldColor: Colors.white.withOpacity(0.9),
                maxLines: 4,
                textFieldController: textController,
                hintText: "Enter notes",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  addNote();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogBoxEdit({required String title, required String content, required int id}) async {
    titleController.text = title;
    textController.text = content;

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Note",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                textFieldColor: Colors.white.withOpacity(0.9),
                maxLines: 1,
                textFieldController: titleController,
                hintText: "Edit title",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                textFieldColor: Colors.white.withOpacity(0.9),
                maxLines: 4,
                textFieldController: textController,
                hintText: "Edit notes",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  editNoteHandler(id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => showDialogBox(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Text("Add Short Notes", style: twenty600TextStyle(color: Colors.black)),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: ListTile(
                      title: Text(note['title'].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(note['body'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.penToSquare, color: Colors.red),
                              onPressed: () => showDialogBoxEdit(
                                title: note['title'].toString(),
                                content: note['body'].toString(),
                                id: note['id'],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.trash, color: Colors.red),
                              onPressed: () => deleteNoteHandler(note['id']),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


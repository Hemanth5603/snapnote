import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snapnote/views/add_note.dart';
import 'package:snapnote/views/note_detail.dart';
import '../db/notes_database.dart';
import '../model/note_model.dart';

import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context){
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'SnapNote',
            style: TextStyle(fontSize: 26),
          ),
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No notes, wanna add one ??',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  : ListView.builder(
                    itemCount: notes.length,
                      itemBuilder: (context,index){
                        final note = notes[index];
                        return GestureDetector(
                          child: NoteCard(w:w,h: h,note: note,index:index),
                          onTap: ()async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=>NoteDetailPage(noteId: note.id!)
                            ));
                            refreshNotes();
                          },
                        );
                    }
                  ), 
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: const Icon(Icons.add,color: Colors.black,),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );
            refreshNotes();
          },
        ),
      );
}




























  Widget buildNotes(w, h) => StaggeredGrid.count(
      // itemCount: notes.length,
      // staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        notes.length,
        (index) {
          final note = notes[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(noteId: note.id!),
                ));

                refreshNotes();
              },
              child: NoteCard(note: note, index: index,w: w,h: h,),
            ),
          );
        },
      ));
}





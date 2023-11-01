import 'package:flutter/material.dart';
import 'package:snapnote/views/add_note.dart';
import '../db/notes_database.dart';
import '../model/note_model.dart';


class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);
    note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context){
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        margin:const EdgeInsets.all(8),
        width: w,
        height: h * 0.06,
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: w * 0.44,
                height: h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 6, 28, 45)
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Edit",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      Icon(Icons.edit,color: Colors.white,),
                    ],
                  ),
                ),
              ),
              onTap: () async {
                if (isLoading) return;

                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEditNotePage(note: note),
                ));
                refreshNote();
              }
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: w * 0.44,
                height: h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 56, 15, 12)
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Delete",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      Icon(Icons.delete,color: Colors.white,),
                    ],
                  ),
                ),
              ),
              onTap: () async {
               await NotesDatabase.instance.delete(widget.noteId);
               Navigator.of(context).pop();
              }
            ),
          ],
        )
      ),
        appBar: AppBar(
          
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    const SizedBox(height: 8),
                    Text(
                      note.description,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );
  }

  
}

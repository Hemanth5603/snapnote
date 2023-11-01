import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/note_model.dart';


class NoteCard extends StatelessWidget {
  const NoteCard({super.key,required this.note,required this.index,required this.w,required this.h});
  final Note note;
  final int index;
  final double w;
  final double h;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h * 0.18,
      margin:const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 33, 34, 38),
      ),
      child: Row(
        children: [
          Container(
            width: w* 0.02,
            height: h * 0.18,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              color: Color.fromARGB(255, 249, 83, 0),
            ),
          ),
          SizedBox(
            width: w * 0.9,
            height: h * 0.18,
            child: Padding(
              padding:const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note.title,style:const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                    width: w,
                    height: 1,
                    color: const Color.fromARGB(255, 81, 81, 81),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: w * 0.9,
                    height: h * 0.09,
                    child: Text(note.description,style:const TextStyle(fontSize: 16,color: Colors.grey),),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
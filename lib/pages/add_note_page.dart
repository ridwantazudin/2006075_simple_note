import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes/db/database_service.dart';
import 'package:simple_notes/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, this.note});

  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late TextEditingController _tittleController;
  late TextEditingController _descController;

  final DatabaseService dbService = DatabaseService();

  @override
  void initState() {
    _tittleController = TextEditingController();
    _descController = TextEditingController();

    if(widget.note != null) {
      _tittleController.text = widget.note!.title;
      _descController.text = widget.note!.desc;
    }
    super.initState();
  }

  @override
  void dispose() {
    _tittleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note!= null? "Edit Note" : "Add Note",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if(value == '') {
                    return "Judul Tidak boleh Kosong";
                  } else {
                    return null;
                  }
                },
                controller: _tittleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukan Judul',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
              ),
              TextFormField(
                validator: (value) {
                  if(value == '') {
                    return "Deskripsi Tidak boleh Kosong";
                  } else {
                    return null;
                  }
                },
                controller: _descController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukan Deskripsi',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  )
                ),
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if(_formkey.currentState!.validate()) {
            Note tempNote = Note(
              title: _tittleController.text, 
              desc: _descController.text, 
              createAt: DateTime.now(),
              );
              if(widget.note != null) {
                dbService.editNote(widget.note!.key,tempNote).then((value) {
                  GoRouter.of(context).pop();
                });
              } else {
                dbService.addNote(tempNote).then((value) {
                  GoRouter.of(context).pop();
                });  
              }
          }
        }, 
        label: const Text('Simpan'),
        icon: const Icon(Icons.save),
        ),
    );
  }
}
import 'package:bmi/views/notes/score_view.dart';
import 'package:flutter/material.dart';
import 'package:bmi/services/auth/auth_service.dart';
import 'package:bmi/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:bmi/utilities/generics/get_arguments.dart';
import 'package:bmi/services/cloud/cloud_note.dart';
import 'package:bmi/services/cloud/firebase_cloud_storage.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;
  late final TextEditingController _createdAtController;
  double bmiValue = 0.0;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _weightController = TextEditingController();
    _heightController = TextEditingController();
    _createdAtController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }

    final weight = _weightController.text;
    final height = _heightController.text;
    final createdAt = _createdAtController.text;
    await _notesService.updateNote(
      documentId: note.documentId,
      weightVal: double.parse(weight),
      heightVal: double.parse(height),
      bmiVal: double.parse(weight) /
          ((double.parse(height) / 100) * (double.parse(height) / 100)),
      createdAtVal: DateTime.parse(createdAt),
    );
  }

  void _setupTextControllerListener() async {
    _weightController.removeListener(_textControllerListener);
    _weightController.addListener(_textControllerListener);

    _heightController.removeListener(_textControllerListener);
    _heightController.addListener(_textControllerListener);

    _createdAtController.removeListener(_textControllerListener);
    _createdAtController.addListener(_textControllerListener);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _weightController.text = widgetNote.weightVal.toString();
      _heightController.text = widgetNote.heightVal.toString();
      bmiValue = widgetNote.bmiVal;
      _createdAtController.text = widgetNote.createdAtVal.toString();
      return widgetNote;
    } else {
      _createdAtController.text = DateTime.now().toString();
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_weightController.text.isEmpty &&
        _heightController.text.isEmpty &&
        note != null) {
      _notesService.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;

    final weight = _weightController.text;
    final height = _heightController.text;
    // final bmi = _bmiController.text;
    final createdAt = _createdAtController.text;
    if (note != null && weight.isNotEmpty && height.isNotEmpty) {
      await _notesService.updateNote(
        documentId: note.documentId,
        weightVal: double.parse(weight),
        heightVal: double.parse(height),
        // bmiVal: double.parse(bmi),
        bmiVal: double.parse(weight) /
            ((double.parse(height) / 100) * (double.parse(height) / 100)),
        createdAtVal: DateTime.parse(createdAt),
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _weightController.dispose();
    _heightController.dispose();
    _createdAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   context.loc.note,
        // ),
        actions: [
          IconButton(
            onPressed: () async {
              final bmi = bmiValue.toStringAsFixed(1);
              if (_note == null || bmi.isEmpty) {
                await showCannotShareEmptyNoteDialog(context);
              } else {
                Share.share(bmi);
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  ScoreView(
                    bmiValue: bmiValue,
                  ),
                  const SizedBox(height: 40.0),
                  const Text('Weight'),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      // hintText: context.loc.start_typing_your_note,
                      hintText: 'Weight',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text('Height'),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      // hintText: context.loc.start_typing_your_note,
                      hintText: 'Height',
                    ),
                  ),
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

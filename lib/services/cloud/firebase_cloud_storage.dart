import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bmi/services/cloud/cloud_note.dart';
import 'package:bmi/services/cloud/cloud_storage_constants.dart';
import 'package:bmi/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('bmi');

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required double heightVal,
    required double weightVal,
    required double bmiVal,
    required DateTime createdAtVal,
  }) async {
    try {
      await notes.doc(documentId).update({
        height: heightVal,
        weight: weightVal,
        bmi: bmiVal,
        createdAt: createdAtVal,
      });
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) {
    final allNotes = notes
        .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
        .snapshots()
        .map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc)));
    return allNotes;
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      ownerUserIdFieldName: ownerUserId,
      weight: 0.0,
      height: 0.0,
      bmi: 0.0,
      createdAt: DateTime.now(),
    });
    final fetchNote = await document.get();
    return CloudNote(
      documentId: fetchNote.id,
      ownerUserId: ownerUserId,
      weightVal: 0.0,
      heightVal: 0.0,
      bmiVal: 0.0,
      createdAtVal: DateTime.now(),
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}

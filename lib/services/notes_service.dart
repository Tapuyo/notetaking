import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notetaking/models/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesService {
  Future<List<NoteModel>> getAllNotes() async {
    List<NoteModel> ntres = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String actionNote = prefs.getString('notes') ?? '';
    if (actionNote.isNotEmpty) {
      var data = json.decode(actionNote);
      for (var i in data) {
        ntres.add(NoteModel.fromJson(i));
      }
    }
    return ntres;
  }

  void saveNotes(List<NoteModel> ntList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var saveNt = jsonEncode(ntList);
    await prefs.setString('notes', saveNt);
  }
}

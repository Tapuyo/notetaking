// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';


part 'notes_model.freezed.dart';

part 'notes_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  const factory NoteModel({
    required String title,
    required String note,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, Object?> json)
      => _$NoteModelFromJson(json);


}
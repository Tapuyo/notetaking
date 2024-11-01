import 'package:bloc/bloc.dart';
import 'package:notetaking/models/notes_model.dart';
import 'package:notetaking/services/notes_service.dart';
// import 'package:equatable/equatable.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<LoadItemCounter>((event, emit)async {
      await Future<void>.delayed(const Duration(seconds: 1));
      NotesService notesService = NotesService();
      List<NoteModel> res = await notesService.getAllNotes();
      emit(ItemsLoaded(item: res));
        notesService.saveNotes(List.from(res));
    });
    on<AddItemCounter>((event, emit) {
      if(state is ItemsLoaded){
         NotesService notesService = NotesService();
        final state = this.state as ItemsLoaded;
        emit(ItemsLoaded(item: List.from(state.item)..add(event.item)));
        notesService.saveNotes(List.from(state.item)..add(event.item));
      }
    });
    on<RemoveItemCounter>((event, emit) {
         if(state is ItemsLoaded){
            NotesService notesService = NotesService();
        final state = this.state as ItemsLoaded;
        emit(ItemsLoaded(item: List.from(state.item)..remove(event.item)));
        notesService.saveNotes(List.from(state.item)..remove(event.item));
      }
    });

    on<UpdateItemCounter>((event, emit) {
         if(state is ItemsLoaded){
           NotesService notesService = NotesService();
        final state = this.state as ItemsLoaded;
        emit(ItemsLoaded(item: List.from(state.item)..[event.index] = event.item));
        notesService.saveNotes(List.from(state.item)..[event.index] = event.item);
      }
    });
  }

  // Future<List<ItemModel>> callAPI(LoadItemCounter event, Emitter<ItemsState> emit)async {
  //   return [];
  // }
}

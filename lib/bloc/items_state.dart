part of 'items_bloc.dart';

sealed class ItemsState {
  const ItemsState();
  
  @override
  List<Object> get props => [];
}

final class ItemsInitial extends ItemsState {}

final class ItemsLoaded extends ItemsState {
  final List<NoteModel> item;
  const ItemsLoaded({required this.item});

  @override
  List<Object> get props => [item];

}

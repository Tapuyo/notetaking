part of 'items_bloc.dart';

sealed class ItemsEvent  {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class LoadItemCounter extends ItemsEvent{}

class AddItemCounter extends ItemsEvent{
  final NoteModel item;
  
  const AddItemCounter(this.item);

  @override
  List<Object> get props => [];
}

class RemoveItemCounter extends ItemsEvent{
  final NoteModel item;

  const RemoveItemCounter(this.item);

  @override
  List<Object> get props => [];
}

class UpdateItemCounter extends ItemsEvent{
  final NoteModel item;
  final int index;

  const UpdateItemCounter(this.item, this.index);

  @override
  List<Object> get props => [];
}
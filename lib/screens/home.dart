import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:notetaking/bloc/items_bloc.dart';
import 'package:notetaking/models/notes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Note Taking App'),
        ),
        body: Center(
          child: BlocBuilder<ItemsBloc, ItemsState>(
            builder: (context, state) {
              if (state is ItemsInitial) {
                return const CircularProgressIndicator();
              }
              if (state is ItemsLoaded) {
                if (state.item.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children:
                          List<Widget>.generate(state.item.length, (index) {
                        NoteModel note = state.item[index];
                        return GridTile(
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                titleController.text = note.title;
                                noteController.text = note.note;
                              });
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Add a new notes'),
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black45),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: titleController,
                                                autofocus: true,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Enter title."),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black45),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: noteController,
                                                autofocus: true,
                                                maxLines: 8,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Enter note here."),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Update'),
                                        onPressed: () {
                                          NoteModel newNote = NoteModel(
                                              title: titleController.text,
                                              note: noteController.text);
                                          context
                                              .read<ItemsBloc>()
                                              .add(UpdateItemCounter(newNote, index));

                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
                                // color: Colors.blue.shade200,
                                child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(note.note),
                                  const Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ItemsBloc>()
                                            .add(RemoveItemCounter(note));
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 20,
                                      ))
                                ],
                              ),
                            )),
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No notes found.'),
                  );
                }
              } else {
                return const Center(
                  child: Text('Something went wrong.'),
                );
              }
            },
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                setState(() {
                  titleController.text = '';
                  noteController.text = '';
                });
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add a new notes'),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: titleController,
                                  autofocus: true,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter title."),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: noteController,
                                  autofocus: true,
                                  maxLines: 8,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter note here."),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text('Add'),
                          onPressed: () {
                            NoteModel newNote = NoteModel(
                                title: titleController.text,
                                note: noteController.text);
                            context
                                .read<ItemsBloc>()
                                .add(AddItemCounter(newNote));

                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            // FloatingActionButton(
            //   onPressed: () {
            //     context
            //         .read<ItemsBloc>()
            //         .add(RemoveItemCounter(NoteModel.item[0]));
            //   },
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.remove),
            // ),
          ],
        ));
  }
}

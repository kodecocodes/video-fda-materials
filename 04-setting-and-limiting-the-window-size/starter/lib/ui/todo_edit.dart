/*
 * Copyright (c) 2023 Kodeco LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * This project and source code may use libraries or frameworks that are
 * released under various Open-Source licenses. Use of those libraries and
 * frameworks are governed by their own individual licenses.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/repository.dart';
import '../models/models.dart';

import 'dialogs.dart';

class TodoEditor extends ConsumerStatefulWidget {
  final Todo todo;

  const TodoEditor({Key? key, required this.todo}) : super(key: key);

  @override
  ConsumerState createState() => _TodoEditorState();
}

class _TodoEditorState extends ConsumerState<TodoEditor> {
  final notesController = TextEditingController();
  late Todo editingTodo;

  @override
  void initState() {
    super.initState();
    editingTodo = widget.todo;
    notesController.text = widget.todo.notes ?? '';
    notesController.addListener(() {
      editingTodo = editingTodo.copyWith(notes: notesController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.read(repositoryProvider);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Name:'),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration:
                    const InputDecoration(border: UnderlineInputBorder()),
                    autofocus: false,
                    controller: TextEditingController(text: widget.todo.name),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Checkbox(
                  value: widget.todo.finished,
                  onChanged: (value) =>
                      setState(() {
                        if (value != null) {
                          editingTodo = editingTodo.copyWith(finished: value);
                        }
                      }),),
                const Text('Finished'),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: const [
                Text('Notes:'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: TextField(
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                autofocus: false,
                controller: notesController,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    repository.updateTodo(widget.todo);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    areYouSureDelete(context,
                        'Are you sure you want to delete ${widget.todo.name}',
                            (deleted) {
                          if (deleted) {
                            repository.deleteTodo(widget.todo);
                            Navigator.of(context).pop();
                          }
                        });
                  },
                  child: const Text('Delete'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),);
  }
}

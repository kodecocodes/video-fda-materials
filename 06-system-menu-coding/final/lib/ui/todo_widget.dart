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
import '../controllers/list_controller.dart';
import '../models/models.dart';
import '../db/repository.dart';

import 'todo_item.dart';

//ignore: must_be_immutable
class TodoWidget extends ConsumerWidget {
  final String todoListName;
  late ListController listController;

  TodoWidget({Key? key, required this.todoListName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listController = ref.read(listControllerProvider);
    final repository = ref.read(repositoryProvider);
    return StreamBuilder<List<Todo>>(
      stream: repository.watchAllTodos(listController.currentCategory.id),
      builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState != ConnectionState.active) {
          return const CircularProgressIndicator();
        }
        final todos = snapshot.data ?? [];
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Todos', textAlign: TextAlign.center),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TodoItem(
                      todo: todo,
                      todoListName: todoListName,
                    ),
                  );
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                addTodo(context, repository, listController.currentCategory,
                    listController);
              },
            ),
          ],
        );
      },
    );
  }

  void addTodo(BuildContext context, Repository repository, Category category,
      ListController listController) {
    final controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                autofocus: true,
                controller: controller,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Todo Name'),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      var todo = Todo(
                          id: -1,
                          name: controller.text.trim(),
                          category: category.id);
                      final id = await repository.addTodo(todo);
                      todo = todo.copyWith(id: id);
                      listController.setCurrentTodo(todo);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add')),
              ]);
        });
  }
}

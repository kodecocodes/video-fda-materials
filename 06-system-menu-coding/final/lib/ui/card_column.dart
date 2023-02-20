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
import '../models/models.dart';
import '../controllers/list_controller.dart';
import '../db/repository.dart';

import 'dialogs.dart';
import 'todo_card.dart';

var colors = [
  Colors.green[100],
  Colors.blue[100],
  Colors.red[100],
  Colors.yellow[100]
];

// ignore: must_be_immutable
class CardColumn extends ConsumerWidget {
  final TodoList todoList;
  late String todoListName;
  late ListController listController;

  CardColumn({Key? key, required this.todoList}) : super(key: key) {
    todoListName = todoList.name;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listController = ref.read(listControllerProvider);
    listController.setCurrentList(todoList);
    final repository = ref.read(repositoryProvider);
    repository.firstCategory(todoList.id).then((category) {
      if (category != null) {
        listController.setCurrentCategory(category);
        repository.firstTodo(category.id).then((todo) {
          if (todo != null) {
            listController.setCurrentTodo(todo);
          }
        });
      }
    });
    return StreamBuilder<List<Category>>(
        stream: repository.watchAllCategories(todoList.id),
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.active) {
            return const CircularProgressIndicator();
          }
          final categories = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        addCategory(context, repository, listController, todoList.id);
                      },
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final colorIndex = index % colors.length;
                        return buildListCard(ref,
                            categories[index], colors[colorIndex]!);
                      }),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    areYouSureDelete(context,
                        'Are you sure you want to delete ${todoList.name}',
                        (deleted) {
                      if (deleted) {
                        repository.deleteTodoList(todoList);
                      }
                    });
                  },
                ),
              ],
            ),
          );
        },
    );
  }

  Widget buildListCard(WidgetRef ref, Category category, Color color) {
    final repository = ref.read(repositoryProvider);
    return StreamBuilder<List<Todo>>(
        stream: repository.watchAllTodos(category.id),
        builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.active) {
            return const CircularProgressIndicator();
          }
          final todos = snapshot.data ?? [];
          return SizedBox(
            width: 280,
            child: Card(
              color: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(category.name,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14)),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            addTodo(context, repository, listController, category.id);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final todo = todos[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [TodoCard(todo: todo)],
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        areYouSureDelete(context,
                            'Are you sure you want to delete ${category.name}',
                            (deleted) {
                          if (deleted) {
                            repository.deleteCategory(category);
                            listController.removeCurrentCategory(category);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}

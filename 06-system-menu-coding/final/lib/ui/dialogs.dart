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
import '../controllers/list_controller.dart';
import '../db/repository.dart';
import '../models/models.dart';

void addList(BuildContext context, Repository repository, ListController listController) {
  final controller = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Add List'),
      content: TextField(
        autofocus: true,
        controller: controller,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter a List Name'),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              var todoList = TodoList(name: controller.text.trim(), id: -1);
              final id = await repository.addTodoList(todoList);
              todoList = todoList.copyWith(id: id);
              listController.setCurrentList(todoList);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Add')),
      ]));
}

void addCategory(BuildContext context,
    Repository repository, ListController listController, int todoId) {
  final textController = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Add Category'),
      content: TextField(
        autofocus: true,
        controller: textController,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter a Category Name'),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              var category =
                  Category(name: textController.text.trim(), todoList: todoId, id: -1);
              final id = await repository.addCategory(category);
              category = category.copyWith(id: id);
              listController.setCurrentCategory(category);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Add')),
      ]));
}

void addTodo(BuildContext context,
    Repository repository, ListController listController, int categoryId) {
  final textController = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        autofocus: true,
        controller: textController,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Enter a Todo Name'),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              var todo =
                  Todo(name: textController.text.trim(), category: categoryId, id: -1);
              final id = await repository.addTodo(todo);
              todo = todo.copyWith(id: id);
              listController.setCurrentTodo(todo);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('Add')),
      ]));
}

typedef DeleteCallback = void Function(bool delete);

void areYouSureDelete(BuildContext context, String title, DeleteCallback callback) {
  showDialog(context: context, builder: (context) => AlertDialog(title: Text(title), actions: <Widget>[
    TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel')),
    TextButton(
        onPressed: () {
          Navigator.pop(context);
          callback(true);
        },
        child: const Text('Delete')),
  ]));
}

/*
 * Copyright (c) 2021 Razeware LLC
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
import 'dart:convert';
import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:menubar/menubar.dart';
import '../controllers/todo_controller.dart';
import '../models/lists.dart';
import '../db/repository.dart';

import 'dialogs.dart';

void createMenus() {
  setApplicationMenu([
    createFileMenu(),
    createEditMenu(),
    createTodosMenu(),
    createFindMenu(),
    createHelpMenu(),
  ]);
}

Submenu createFileMenu() {
  return Submenu(label: 'File', children: [
    MenuItem(label: 'Import', onClicked: () => handleImport()),
    MenuItem(label: 'Export', onClicked: () => handleExport())
  ]);
}

void handleImport() async {
}

void handleExport() async {
  final path = await FilesystemPicker.open(
    title: 'Save to folder',
    context: Get.context!,
    rootDirectory: Directory.current,
    fsType: FilesystemType.folder,
    pickText: 'Save file to this folder',
    folderIconColor: Colors.teal,
  );

  if (path != null) {
    final file = File(path + '/exports.todo');
    if (await file.exists()) {
      await file.delete();
    }
    final repository = Get.find<Repository>();
    final todoController = Get.find<TodoController>();
    final todoLists = todoController.todoList.value;
    for (final list in todoLists) {
      await repository.fillTodoList(list);
    }
    await file.writeAsString(jsonEncode(todoLists));
  }
}

Submenu createEditMenu() {
  return Submenu(label: 'Edit', children: [
    MenuItem(label: 'Cut', onClicked: () => handleCut()),
    MenuItem(label: 'Copy', onClicked: () => handleCopy()),
    MenuItem(label: 'Paste', onClicked: () => handlePaste())
  ]);
}

void handlePaste() {}

void handleCopy() {}

void handleCut() {}

Submenu createTodosMenu() {
  return Submenu(label: 'Todos', children: [
    Submenu(label: 'New', children: [
      MenuItem(label: 'List', onClicked: () => newList()),
      MenuItem(label: 'Category', onClicked: () => newCategory()),
      MenuItem(label: 'Todo', onClicked: () => newTodo()),
    ]),
    Submenu(label: 'Delete', children: [
      MenuItem(label: 'List', onClicked: () => deleteList()),
      MenuItem(label: 'Category', onClicked: () => deleteCategory()),
      MenuItem(label: 'Todo', onClicked: () => deleteTodo()),
    ])
  ]);
}

void deleteTodo() {}

void deleteCategory() {}

void deleteList() {}

void newCategory() {}

void newTodo() {}

void newList() {
  addList(Get.find<Repository>());
}

Submenu createFindMenu() {
  return Submenu(label: 'Find', children: [
    MenuItem(label: 'Search', onClicked: () => handleSearch()),
    MenuItem(label: 'Next', onClicked: () => handleNext()),
    MenuItem(label: 'Previous', onClicked: () => handlePrevious())
  ]);
}

void handlePrevious() {}

void handleNext() {}

void handleSearch() {}

Submenu createHelpMenu() {
  return Submenu(
      label: 'Help',
      children: [MenuItem(label: 'Help', onClicked: () => handleHelp())]);
}

void handleHelp() {}


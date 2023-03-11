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
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menubar/menubar.dart';
import 'package:todo/controllers/list_controller.dart';
import '../controllers/todo_controller.dart';
import '../main.dart';
import '../models/lists.dart';
import '../db/repository.dart';

import 'dialogs.dart';

final menuProvider = Provider<MenuProvider>((ref) {
  return MenuProvider(ref);
});

class MenuProvider {
  final ProviderRef ref;

  MenuProvider(this.ref);
  
  List<PlatformMenu> createMenus() {
    return [
      createFileMenu(),
      createEditMenu(),
      createTodosMenu(),
      createFindMenu(),
      createHelpMenu(),
    ];
  }

  void createWindowsMenus() {
    setApplicationMenu([
      createWindowsFileMenu(),
      createWindowsEditMenu(),
      createWindowsTodosMenu(),
      createWindowsFindMenu(),
      createWindowsHelpMenu(),
    ]);
  }

  PlatformMenu createFileMenu() {
    return PlatformMenu(label: 'File', menus: [
      PlatformMenuItem(label: 'Import', onSelected: () => handleImport()),
      PlatformMenuItem(label: 'Export', onSelected: () => handleExport()),
      PlatformMenuItemGroup(members: [
        PlatformMenuItem(
            label: 'Quit',
            onSelected: () => handleQuit(),
            shortcut: const SingleActivator(
                LogicalKeyboardKey.keyQ, meta: true))
      ])
    ]);
  }

  NativeSubmenu createWindowsFileMenu() {
    return NativeSubmenu(label: 'File', children: [
      NativeMenuItem(label: 'Import', onSelected: () => handleImport()),
      NativeMenuItem(label: 'Export', onSelected: () => handleExport()),
      NativeMenuItem(
          label: 'Quit',
          onSelected: () => handleQuit(),
          shortcut:
          LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyQ)),
    ]);
  }

  void handleImport() async {} 
  void handleExport() async {}

  PlatformMenu createEditMenu() {
    return PlatformMenu(label: 'Edit', menus: [
      PlatformMenuItem(label: 'Cut', onSelected: () => handleCut()),
      PlatformMenuItem(label: 'Copy', onSelected: () => handleCopy()),
      PlatformMenuItem(label: 'Paste', onSelected: () => handlePaste())
    ]);
  }

  NativeSubmenu createWindowsEditMenu() {
    return NativeSubmenu(label: 'Edit', children: [
      NativeMenuItem(label: 'Cut', onSelected: () => handleCut()),
      NativeMenuItem(label: 'Copy', onSelected: () => handleCopy()),
      NativeMenuItem(label: 'Paste', onSelected: () => handlePaste())
    ]);
  }

  void handlePaste() {}

  void handleCopy() {}

  void handleCut() {}

  PlatformMenu createTodosMenu() {
    return PlatformMenu(label: 'Todos', menus: [
      PlatformMenu(label: 'New', menus: [
        PlatformMenuItem(label: 'List', onSelected: () => newList()),
        PlatformMenuItem(label: 'Category', onSelected: () => newCategory()),
        PlatformMenuItem(label: 'Todo', onSelected: () => newTodo()),
      ]),
      PlatformMenu(label: 'Delete', menus: [
        PlatformMenuItem(label: 'List', onSelected: () => deleteList()),
        PlatformMenuItem(label: 'Category', onSelected: () => deleteCategory()),
        PlatformMenuItem(label: 'Todo', onSelected: () => deleteTodo()),
      ])
    ]);
  }

  NativeSubmenu createWindowsTodosMenu() {
    return NativeSubmenu(label: 'Todos', children: [
      NativeSubmenu(label: 'New', children: [
        NativeMenuItem(label: 'List', onSelected: () => newList()),
        NativeMenuItem(label: 'Category', onSelected: () => newCategory()),
        NativeMenuItem(label: 'Todo', onSelected: () => newTodo()),
      ]),
      NativeSubmenu(label: 'Delete', children: [
        NativeMenuItem(label: 'List', onSelected: () => deleteList()),
        NativeMenuItem(label: 'Category', onSelected: () => deleteCategory()),
        NativeMenuItem(label: 'Todo', onSelected: () => deleteTodo()),
      ])
    ]);
  }

  void deleteTodo() {}

  void deleteCategory() {}

  void deleteList() {}

  void newCategory() {}

  void newTodo() {}

  void newList() {
    addList(
        navigatorKey.currentContext!,
        ProviderScope.containerOf(navigatorKey.currentContext!)
            .read(repositoryProvider),
        ProviderScope.containerOf(navigatorKey.currentContext!)
            .read(listControllerProvider));
  }

  PlatformMenu createFindMenu() {
    return PlatformMenu(label: 'Find', menus: [
      PlatformMenuItem(label: 'Search', onSelected: () => handleSearch()),
      PlatformMenuItem(label: 'Next', onSelected: () => handleNext()),
      PlatformMenuItem(label: 'Previous', onSelected: () => handlePrevious())
    ]);
  }

  NativeSubmenu createWindowsFindMenu() {
    return NativeSubmenu(label: 'Find', children: [
      NativeMenuItem(label: 'Search', onSelected: () => handleSearch()),
      NativeMenuItem(label: 'Next', onSelected: () => handleNext()),
      NativeMenuItem(label: 'Previous', onSelected: () => handlePrevious())
    ]);
  }

  void handlePrevious() {}

  void handleNext() {}

  void handleSearch() {}

  PlatformMenu createHelpMenu() {
    return PlatformMenu(
        label: 'Help',
        menus: [
          PlatformMenuItem(label: 'Help', onSelected: () => handleHelp())
        ]);
  }

  NativeSubmenu createWindowsHelpMenu() {
    return NativeSubmenu(label: 'Help', children: [
      NativeMenuItem(label: 'Help', onSelected: () => handleHelp())
    ]);
  }

  void handleHelp() {}

  void handleQuit() {
    SystemNavigator.pop();
  }
}

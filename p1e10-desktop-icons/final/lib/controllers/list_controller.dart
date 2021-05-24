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
import 'package:get/get.dart';
import '../models/todo.dart';
import '../models/category.dart';
import '../models/lists.dart';

class ListController extends GetxController {
  var currentList = TodoList(name: 'empty').obs;
  var currentCategory = Category(todoList: -1, name: 'empty').obs;
  var currentTodo = Todo(name: 'empty', category: -1).obs;

  static ListController get to => Get.find();

  void updateList(TodoList updatedList) {
    currentList.value = updatedList;
    update();
  }

  void setCurrentCategory(Category category) {
    currentCategory.value = category;
    update();
  }

  void removeCurrentCategory(Category category) {
    currentCategory.value = currentList.value.categories.isNotEmpty
        ? currentList.value.categories.first
        : Category(todoList: -1, name: 'empty');
    update();
  }

  void setCurrentTodo(Todo todo) {
    currentTodo.value = todo;
    update();
  }

  void removeCurrentTodo(Todo todo) {
    currentTodo.value = currentCategory.value.todos.isNotEmpty
        ? currentCategory.value.todos.first
        : Todo(name: 'empty', category: -1);
    update();
  }

  ListController(TodoList todoList) {
    updateList(todoList);
  }
}

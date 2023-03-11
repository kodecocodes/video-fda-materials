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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database.dart';
import '../models/models.dart';

final repositoryProvider = Provider<Repository>((ref) {
  return Repository();
});

class Repository {

  late TodoDatabase _todoDatabase;
  late TodoDao _todoDao;
  late CategoryDao _categoryDao;
  late ListDao _listDao;

  Repository() {
    init();
  }

  void init() async {
    _todoDatabase = TodoDatabase();
    _todoDao = _todoDatabase.todoDao;
    _categoryDao = _todoDatabase.categoryDao;
    _listDao = _todoDatabase.listDao;
  }

  Future<int> addTodoList(TodoList list) {
    return Future.value(_listDao.insertList(listToListData(list)));
  }

  Future<bool> updateTodoList(TodoList list) {
    return Future.value(_listDao.updateList(listToListData(list)));
  }

  Future<void> deleteTodoList(TodoList list) async {
    // 1st go through all categories and delete todos
    final categories = await _categoryDao.allListCategories(list.id);
    await Future.forEach(categories, (category) async {
      await deleteAllTodos(category.id);
      await deleteCategoryById(category.id);
    });
    _listDao.deleteList(list.id);
    return Future.value();
  }

  Future<List<TodoList>> getTodoLists() {
    return _listDao.allLists().then<List<TodoList>>(
        (List<ListTableData> tododata) => _convertTodoLists(tododata));
  }

  Future<TodoList> fillTodoList(TodoList todoList) async {
    final categories = await getListCategories(todoList.id);
    final updatedCategories = <Category>[];
    await Future.forEach(categories, (Category category) async {
      final todos = await getCategoryTodos(category.id);
      category = category.copyWith(todos: todos);
      updatedCategories.add(category);
    });
    todoList = todoList.copyWith(categories: updatedCategories);
    return todoList;
  }

  Stream<List<TodoList>> watchAllTodoLists() {
    return _listDao.watchAllLists().map<List<TodoList>>(
        (List<ListTableData> tododata) => _convertTodoLists(tododata));
  }

  List<TodoList> _convertTodoLists(List<ListTableData> todoData) {
    final todos = <TodoList>[];
    for (final todo in todoData) {
      todos.add(listDataToList(todo));
    }
    return todos;
  }

  Future<int> addCategory(Category category) {
    return Future.value(
        _categoryDao.insertCategory(categoryToCategoryData(category)));
  }

  Future<bool> updateCategory(Category category) {
    return Future.value(
        _categoryDao.updateCategory(categoryToCategoryData(category)));
  }

  Future<void> deleteCategoryById(int categoryId) {
    _categoryDao.deleteCategory(categoryId);
    return Future.value();
  }

  Future<void> deleteCategory(Category category) {
    deleteAllTodos(category.id);
    _categoryDao.deleteCategory(category.id);
    return Future.value();
  }

  Future<void> deleteAllCategories(int todoListId) {
    _categoryDao.deleteAllCategories(todoListId);
    return Future.value();
  }

  Future<List<Category>> getCategories() {
    return _categoryDao.allCategories().then<List<Category>>(
        (List<CategoryTableData> categoryTableData) =>
            _convertCategories(categoryTableData));
  }

  Future<List<Category>> getListCategories(int listId) {
    return _categoryDao.allListCategories(listId).then<List<Category>>(
        (List<CategoryTableData> categoryTableData) =>
            _convertCategories(categoryTableData));
  }

  Future<Category?> firstCategory(int todoListId) {
    return _categoryDao.firstCategory(todoListId).then(
        (element) => element != null ? categoryDataToCategory(element) : null);
  }

  Stream<List<Category>> watchAllCategories(int todoListId) {
    return _categoryDao.watchAllCategories(todoListId).map<List<Category>>(
        (List<CategoryTableData> categoryTableData) =>
            _convertCategories(categoryTableData));
  }

  List<Category> _convertCategories(List<CategoryTableData> categoryTableData) {
    final categories = <Category>[];
    for (final data in categoryTableData) {
      categories.add(categoryDataToCategory(data));
    }
    return categories;
  }

  Future<int> addTodo(Todo todo) {
    return Future.value(_todoDao.insertTodo(todoToTodoData(todo)));
  }

  Future<bool> updateTodo(Todo todo) {
    return Future.value(_todoDao.updateTodo(todoToTodoData(todo)));
  }

  Future<void> deleteTodo(Todo todo) {
    _todoDao.deleteTodo(todo.id);
    return Future.value();
  }

  Future<void> deleteAllTodos(int categoryId) {
    _todoDao.deleteAllTodos(categoryId);
    return Future.value();
  }

  Future<List<Todo>> getTodos() {
    return _todoDao.allTodos().then<List<Todo>>(
        (List<TodoTableData> tododata) => _convertTodos(tododata));
  }

  Future<List<Todo>> getCategoryTodos(int categoryId) {
    return _todoDao.allCategoryTodos(categoryId).then<List<Todo>>(
        (List<TodoTableData> tododata) => _convertTodos(tododata));
  }

  List<Todo> _convertTodos(List<TodoTableData> tododata) {
    final todos = <Todo>[];
    for (final data in tododata) {
      todos.add(todoDataToTodo(data));
    }
    return todos;
  }

  Stream<List<Todo>> watchAllTodos(int categoryId) {
    return _todoDao.watchAllTodos(categoryId).map<List<Todo>>(
        (List<TodoTableData> tododata) => _convertTodos(tododata));
  }

  Future<Todo?> firstTodo(int categoryId) {
    return _todoDao
        .firstTodo(categoryId)
        .then((element) => element != null ? todoDataToTodo(element) : null);
  }

  Future<List<Todo>> findTodos(String searchText) {
    return _todoDao.findTodos(searchText).then<List<Todo>>(
            (List<TodoTableData> tododata) => _convertTodos(tododata));
  }

  void close() {
    _todoDatabase.close();
  }
}

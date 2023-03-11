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
import 'dart:io';


import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ListTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
}

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get todoList => integer()();

  TextColumn get name => text()();
}

class TodoTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get category => integer()();

  TextColumn get name => text()();

  BoolColumn get finished => boolean().withDefault(const Constant(false))();

  TextColumn get notes => text()();
}

// final executor = LazyDatabase(() async {
//   final dbFolder = await getDatabasesPath();
//   final file = File(p.join(dbFolder, 'todos.sqlite'));
//   return VmDatabase(file);
// });

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
    tables: [ListTable, CategoryTable, TodoTable],
    daos: [ListDao, CategoryDao, TodoDao])
class TodoDatabase extends _$TodoDatabase {
  TodoDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [ListTable])
class ListDao extends DatabaseAccessor<TodoDatabase> with _$ListDaoMixin {
  final TodoDatabase db;

  ListDao(this.db) : super(db);


  Stream<List<ListTableData>> watchAllLists() => select(listTable).watch();

  Future<List<ListTableData>> allLists() => select(listTable).get();

  Future<int> insertList(Insertable<ListTableData> list) =>
      into(listTable).insert(list);

  Future<bool> updateList(Insertable<ListTableData> list) =>
      update(listTable).replace(list);

  Future deleteList(int id) =>
      Future.value((delete(listTable)..where((tbl) => tbl.id.equals(id))).go());

}

@DriftAccessor(tables: [CategoryTable])
class CategoryDao extends DatabaseAccessor<TodoDatabase>
    with _$CategoryDaoMixin {
  final TodoDatabase db;

  CategoryDao(this.db) : super(db);


  Stream<List<CategoryTableData>> watchAllCategories(int todoListId) =>
      (select(categoryTable)..where((tbl) => tbl.todoList.equals(todoListId)))
          .watch();

  Future<List<CategoryTableData>> allListCategories(int todoListId) =>
      (select(categoryTable)..where((tbl) => tbl.todoList.equals(todoListId)))
          .get();

  Future<CategoryTableData?> firstCategory(int todoListId) =>
      (select(categoryTable)..where((tbl) => tbl.todoList.equals(todoListId)))
          .get()
          .then((list) => list.isNotEmpty ? list.first : null);

  Future<List<CategoryTableData>> allCategories() =>
      select(categoryTable).get();

  Future<int> insertCategory(Insertable<CategoryTableData> category) =>
      into(categoryTable).insert(category);

  Future<bool> updateCategory(Insertable<CategoryTableData> category) =>
      update(categoryTable).replace(category);

  Future deleteCategory(int id) => Future.value(
      (delete(categoryTable)..where((tbl) => tbl.id.equals(id))).go());

  Future deleteAllCategories(int todoListId) => Future.value(
      (delete(categoryTable)..where((tbl) => tbl.todoList.equals(todoListId)))
          .go());

}

@DriftAccessor(tables: [TodoTable])
class TodoDao extends DatabaseAccessor<TodoDatabase> with _$TodoDaoMixin {
  final TodoDatabase db;

  TodoDao(this.db) : super(db);

  Stream<List<TodoTableData>> watchAllTodos(int categoryId) =>
      (select(todoTable)..where((tbl) => tbl.category.equals(categoryId)))
          .watch();

  Future<List<TodoTableData>> allCategoryTodos(int categoryId) =>
      (select(todoTable)..where((tbl) => tbl.category.equals(categoryId)))
          .get();

  Future<TodoTableData?> firstTodo(int categoryId) =>
      (select(todoTable)..where((tbl) => tbl.category.equals(categoryId)))
          .get()
          .then((todo) => todo.isNotEmpty ? todo.first : null);

  Future<List<TodoTableData>> findTodos(String searchText) => (select(todoTable)
        ..where((tbl) =>
            tbl.name.like('%$searchText%') | tbl.name.like('%$searchText%')))
      .get();

  Future<List<TodoTableData>> allTodos() => select(todoTable).get();

  Future<int> insertTodo(Insertable<TodoTableData> todo) =>
      into(todoTable).insert(todo);

  Future<bool> updateTodo(Insertable<TodoTableData> todo) =>
      update(todoTable).replace(todo);

  Future deleteTodo(int id) =>
      Future.value((delete(todoTable)..where((tbl) => tbl.id.equals(id))).go());

  Future deleteAllTodos(int categoryId) => Future.value((delete(todoTable)
        ..where((tbl) => tbl.category.equals(categoryId)))
      .go());

}

TodoList listDataToList(ListTableData data) {
  return TodoList(
    id: data.id,
    name: data.name,
  );
}

Insertable<ListTableData> listToListData(TodoList data) {
  var id = const Value<int>.absent();
  if (data.id != -1) id = Value(data.id);
  return ListTableCompanion.insert(
    id: id,
    name: data.name,
  );
}

Category categoryDataToCategory(CategoryTableData data) {
  return Category(
    id: data.id,
    todoList: data.todoList,
    name: data.name,
  );
}

Insertable<CategoryTableData> categoryToCategoryData(Category data) {
  var id = const Value<int>.absent();
  if (data.id != -1) id = Value(data.id);
  return CategoryTableCompanion.insert(
    id: id,
    todoList: data.todoList,
    name: data.name,
  );
}

Todo todoDataToTodo(TodoTableData data) {
  return Todo(
    id: data.id,
    category: data.category,
    name: data.name,
    finished: data.finished,
    notes: data.notes,
  );
}

Insertable<TodoTableData> todoToTodoData(Todo data) {
  var id = const Value<int>.absent();
  if (data.id != -1) id = Value(data.id);
  return TodoTableCompanion.insert(
    id: id,
    category: data.category,
    name: data.name,
    finished: Value(data.finished),
    notes: data.notes ?? '',
  );
}

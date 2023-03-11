// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ListTableTable extends ListTable
    with TableInfo<$ListTableTable, ListTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'list_table';
  @override
  String get actualTableName => 'list_table';
  @override
  VerificationContext validateIntegrity(Insertable<ListTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ListTableTable createAlias(String alias) {
    return $ListTableTable(attachedDatabase, alias);
  }
}

class ListTableData extends DataClass implements Insertable<ListTableData> {
  final int id;
  final String name;
  const ListTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ListTableCompanion toCompanion(bool nullToAbsent) {
    return ListTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ListTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ListTableData copyWith({int? id, String? name}) => ListTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ListTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class ListTableCompanion extends UpdateCompanion<ListTableData> {
  final Value<int> id;
  final Value<String> name;
  const ListTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ListTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ListTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ListTableCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ListTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _todoListMeta =
      const VerificationMeta('todoList');
  @override
  late final GeneratedColumn<int> todoList = GeneratedColumn<int>(
      'todo_list', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, todoList, name];
  @override
  String get aliasedName => _alias ?? 'category_table';
  @override
  String get actualTableName => 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo_list')) {
      context.handle(_todoListMeta,
          todoList.isAcceptableOrUnknown(data['todo_list']!, _todoListMeta));
    } else if (isInserting) {
      context.missing(_todoListMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      todoList: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}todo_list'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final int id;
  final int todoList;
  final String name;
  const CategoryTableData(
      {required this.id, required this.todoList, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo_list'] = Variable<int>(todoList);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      todoList: Value(todoList),
      name: Value(name),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<int>(json['id']),
      todoList: serializer.fromJson<int>(json['todoList']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todoList': serializer.toJson<int>(todoList),
      'name': serializer.toJson<String>(name),
    };
  }

  CategoryTableData copyWith({int? id, int? todoList, String? name}) =>
      CategoryTableData(
        id: id ?? this.id,
        todoList: todoList ?? this.todoList,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('todoList: $todoList, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, todoList, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.todoList == this.todoList &&
          other.name == this.name);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<int> id;
  final Value<int> todoList;
  final Value<String> name;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.todoList = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    required int todoList,
    required String name,
  })  : todoList = Value(todoList),
        name = Value(name);
  static Insertable<CategoryTableData> custom({
    Expression<int>? id,
    Expression<int>? todoList,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todoList != null) 'todo_list': todoList,
      if (name != null) 'name': name,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<int>? id, Value<int>? todoList, Value<String>? name}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      todoList: todoList ?? this.todoList,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todoList.present) {
      map['todo_list'] = Variable<int>(todoList.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('todoList: $todoList, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TodoTableTable extends TodoTable
    with TableInfo<$TodoTableTable, TodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
      'category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finishedMeta =
      const VerificationMeta('finished');
  @override
  late final GeneratedColumn<bool> finished =
      GeneratedColumn<bool>('finished', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("finished" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }),
          defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, category, name, finished, notes];
  @override
  String get aliasedName => _alias ?? 'todo_table';
  @override
  String get actualTableName => 'todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<TodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('finished')) {
      context.handle(_finishedMeta,
          finished.isAcceptableOrUnknown(data['finished']!, _finishedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      finished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}finished'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
    );
  }

  @override
  $TodoTableTable createAlias(String alias) {
    return $TodoTableTable(attachedDatabase, alias);
  }
}

class TodoTableData extends DataClass implements Insertable<TodoTableData> {
  final int id;
  final int category;
  final String name;
  final bool finished;
  final String notes;
  const TodoTableData(
      {required this.id,
      required this.category,
      required this.name,
      required this.finished,
      required this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<int>(category);
    map['name'] = Variable<String>(name);
    map['finished'] = Variable<bool>(finished);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  TodoTableCompanion toCompanion(bool nullToAbsent) {
    return TodoTableCompanion(
      id: Value(id),
      category: Value(category),
      name: Value(name),
      finished: Value(finished),
      notes: Value(notes),
    );
  }

  factory TodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoTableData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<int>(json['category']),
      name: serializer.fromJson<String>(json['name']),
      finished: serializer.fromJson<bool>(json['finished']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<int>(category),
      'name': serializer.toJson<String>(name),
      'finished': serializer.toJson<bool>(finished),
      'notes': serializer.toJson<String>(notes),
    };
  }

  TodoTableData copyWith(
          {int? id,
          int? category,
          String? name,
          bool? finished,
          String? notes}) =>
      TodoTableData(
        id: id ?? this.id,
        category: category ?? this.category,
        name: name ?? this.name,
        finished: finished ?? this.finished,
        notes: notes ?? this.notes,
      );
  @override
  String toString() {
    return (StringBuffer('TodoTableData(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('finished: $finished, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, name, finished, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoTableData &&
          other.id == this.id &&
          other.category == this.category &&
          other.name == this.name &&
          other.finished == this.finished &&
          other.notes == this.notes);
}

class TodoTableCompanion extends UpdateCompanion<TodoTableData> {
  final Value<int> id;
  final Value<int> category;
  final Value<String> name;
  final Value<bool> finished;
  final Value<String> notes;
  const TodoTableCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.name = const Value.absent(),
    this.finished = const Value.absent(),
    this.notes = const Value.absent(),
  });
  TodoTableCompanion.insert({
    this.id = const Value.absent(),
    required int category,
    required String name,
    this.finished = const Value.absent(),
    required String notes,
  })  : category = Value(category),
        name = Value(name),
        notes = Value(notes);
  static Insertable<TodoTableData> custom({
    Expression<int>? id,
    Expression<int>? category,
    Expression<String>? name,
    Expression<bool>? finished,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (finished != null) 'finished': finished,
      if (notes != null) 'notes': notes,
    });
  }

  TodoTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? category,
      Value<String>? name,
      Value<bool>? finished,
      Value<String>? notes}) {
    return TodoTableCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      name: name ?? this.name,
      finished: finished ?? this.finished,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (finished.present) {
      map['finished'] = Variable<bool>(finished.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoTableCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('finished: $finished, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$TodoDatabase extends GeneratedDatabase {
  _$TodoDatabase(QueryExecutor e) : super(e);
  late final $ListTableTable listTable = $ListTableTable(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $TodoTableTable todoTable = $TodoTableTable(this);
  late final ListDao listDao = ListDao(this as TodoDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as TodoDatabase);
  late final TodoDao todoDao = TodoDao(this as TodoDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [listTable, categoryTable, todoTable];
}

mixin _$ListDaoMixin on DatabaseAccessor<TodoDatabase> {
  $ListTableTable get listTable => attachedDatabase.listTable;
}
mixin _$CategoryDaoMixin on DatabaseAccessor<TodoDatabase> {
  $CategoryTableTable get categoryTable => attachedDatabase.categoryTable;
}
mixin _$TodoDaoMixin on DatabaseAccessor<TodoDatabase> {
  $TodoTableTable get todoTable => attachedDatabase.todoTable;
}

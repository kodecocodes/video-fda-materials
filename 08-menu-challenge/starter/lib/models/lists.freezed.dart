// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lists.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoList _$TodoListFromJson(Map<String, dynamic> json) {
  return _TodoList.fromJson(json);
}

/// @nodoc
mixin _$TodoList {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<Category> get categories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoListCopyWith<TodoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoListCopyWith<$Res> {
  factory $TodoListCopyWith(TodoList value, $Res Function(TodoList) then) =
      _$TodoListCopyWithImpl<$Res, TodoList>;
  @useResult
  $Res call({int id, String name, List<Category> categories});
}

/// @nodoc
class _$TodoListCopyWithImpl<$Res, $Val extends TodoList>
    implements $TodoListCopyWith<$Res> {
  _$TodoListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoListCopyWith<$Res> implements $TodoListCopyWith<$Res> {
  factory _$$_TodoListCopyWith(
          _$_TodoList value, $Res Function(_$_TodoList) then) =
      __$$_TodoListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<Category> categories});
}

/// @nodoc
class __$$_TodoListCopyWithImpl<$Res>
    extends _$TodoListCopyWithImpl<$Res, _$_TodoList>
    implements _$$_TodoListCopyWith<$Res> {
  __$$_TodoListCopyWithImpl(
      _$_TodoList _value, $Res Function(_$_TodoList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categories = null,
  }) {
    return _then(_$_TodoList(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TodoList implements _TodoList {
  const _$_TodoList(
      {required this.id,
      required this.name,
      this.categories = const <Category>[]});

  factory _$_TodoList.fromJson(Map<String, dynamic> json) =>
      _$$_TodoListFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey()
  final List<Category> categories;

  @override
  String toString() {
    return 'TodoList(id: $id, name: $name, categories: $categories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoList &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoListCopyWith<_$_TodoList> get copyWith =>
      __$$_TodoListCopyWithImpl<_$_TodoList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoListToJson(
      this,
    );
  }
}

abstract class _TodoList implements TodoList {
  const factory _TodoList(
      {required final int id,
      required final String name,
      final List<Category> categories}) = _$_TodoList;

  factory _TodoList.fromJson(Map<String, dynamic> json) = _$_TodoList.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<Category> get categories;
  @override
  @JsonKey(ignore: true)
  _$$_TodoListCopyWith<_$_TodoList> get copyWith =>
      throw _privateConstructorUsedError;
}

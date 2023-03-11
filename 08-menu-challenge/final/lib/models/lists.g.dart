// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoList _$$_TodoListFromJson(Map<String, dynamic> json) => _$_TodoList(
      id: json['id'] as int,
      name: json['name'] as String,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Category>[],
    );

Map<String, dynamic> _$$_TodoListToJson(_$_TodoList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categories': instance.categories.map((e) => e.toJson()).toList(),
    };

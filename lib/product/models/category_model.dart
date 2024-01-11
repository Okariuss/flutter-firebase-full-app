import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_full_app/product/utility/base/base_firebase_model.dart';

class Category extends Equatable with IdModel, BaseFirebaseModel<Category> {
  const Category({this.detail, this.name, this.id});

  final String? detail;
  final String? name;
  @override
  final String? id;

  @override
  List<Object?> get props => [id];

  Category copyWith({
    String? detail,
    String? name,
    String? id,
  }) {
    return Category(
      detail: detail ?? this.detail,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {'detail': detail, 'name': name, 'id': id};
  }

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category(
      detail: json['detail'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
    );
  }
}

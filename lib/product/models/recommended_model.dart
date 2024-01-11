import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_full_app/product/utility/base/base_firebase_model.dart';

class Recommended extends Equatable
    with IdModel, BaseFirebaseModel<Recommended> {
  final String? image;
  final String? title;
  final String? description;
  @override
  final String? id;

  Recommended({this.image, this.title, this.description, this.id});

  @override
  List<Object?> get props => [image, title, description];

  Recommended copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return Recommended(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }

  @override
  Recommended fromJson(Map<String, dynamic> json) {
    return Recommended(
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
    );
  }
}

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/models/category_model.dart';
import 'package:flutter_firebase_full_app/product/models/news_model.dart';
import 'package:flutter_firebase_full_app/product/utility/exceptions/item_create_exception.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_firebase_full_app/product/utility/image/pick_image.dart';
import 'package:image_picker/image_picker.dart';

class HomeLogic with FirebaseUtility {
  final TextEditingController titleController = TextEditingController();

  Category? _categoryModel;
  List<Category> _categories = [];
  XFile? _selectedFile;
  Uint8List? _selectedFileBytes;

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isValidateAllForm = false;

  List<Category> get categories => _categories;
  Uint8List? get selectedFileBytes => _selectedFileBytes;

  void dispose() {
    titleController.dispose();
    _categoryModel = null;
  }

  void updateCategory(Category category) {
    _categoryModel = category;
  }

  bool checkValidateAndSave(ValueSetter<bool>? onUpdate) {
    final value = formKey.currentState?.validate() ?? false;

    if (value != isValidateAllForm && selectedFileBytes != null) {
      isValidateAllForm = value;
      onUpdate?.call(value);
    }

    return isValidateAllForm;
  }

  Future<void> pickAndCheck(ValueSetter<bool> onUpdate) async {
    _selectedFile = await PickImage().pickImageFromGallery();
    _selectedFileBytes = await _selectedFile?.readAsBytes();
    checkValidateAndSave((value) {});
    onUpdate.call(true);
  }

  Future<void> fetchAllCategory() async {
    final response = await fetchList<Category, Category>(
        Category(), FirebaseCollections.category);

    _categories = response ?? [];
  }

  Future<bool> save() async {
    if (!checkValidateAndSave(null)) return false;
    final imageRef = createImageReference();
    if (imageRef == null) throw ItemCreateException('Image is not empty');
    if (_selectedFileBytes == null) return false;
    await imageRef.putData(_selectedFileBytes!);
    final urlPath = await imageRef.getDownloadURL();
    final response = await FirebaseCollections.news.reference.add(
      News(
        backgroundImage: urlPath,
        category: _categoryModel?.name,
        categoryId: _categoryModel?.id,
        title: titleController.text,
      ).toJson(),
    );

    if (response.id.isEmpty) return false;
    return true;
  }

  Reference? createImageReference() {
    if (_selectedFile == null ||
        (_selectedFile?.name == null || _selectedFile!.name.isEmpty)) {
      return null;
    }
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(_selectedFile!.name);
    return imageRef;
  }
}

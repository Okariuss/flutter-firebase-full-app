import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/home_create/home_create_view.dart';
import 'package:flutter_firebase_full_app/feature/home_create/home_logic.dart';

mixin HomeCreateMixin on State<HomeCreateView> {
  late final HomeLogic _homeLogic;

  HomeLogic get homeLogic => _homeLogic;

  @override
  void initState() {
    super.initState();
    _homeLogic = HomeLogic();
    _fetchInitialCategory();
  }

  @override
  void dispose() {
    super.dispose();
    _homeLogic.dispose();
  }

  Future<void> _fetchInitialCategory() async {
    await _homeLogic.fetchAllCategory();
    setState(() {});
  }
}

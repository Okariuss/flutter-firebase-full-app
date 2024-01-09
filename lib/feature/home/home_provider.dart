// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_full_app/product/models/news_model.dart';
import 'package:flutter_firebase_full_app/product/models/recommended_model.dart';
import 'package:flutter_firebase_full_app/product/models/tag_model.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider extends StateNotifier<HomeState> with FirebaseUtility {
  HomeProvider() : super(HomeState());

  List<Tag> _fullTagList = [];
  List<Tag> get fullTagList => _fullTagList;

  Future<void> fetchNews() async {
    final items = await fetchList<News, News>(News(), FirebaseCollections.news);
    state = state.copyWith(news: items);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    Future.wait([fetchNews(), fetchTags(), fetchRecommended()]);
    state = state.copyWith(isLoading: false);
  }

  Future<void> changeTagActiveStatus(Tag newTag) async {
    try {
      final tagCollection = FirebaseCollections.tag.reference;

      await _deactivateCurrentActiveTag(tagCollection);

      await _activateNewTag(tagCollection, newTag);

      await fetchTags();
    } catch (e) {
      print('Error updating tag: $e');
    }
  }

  Future<void> _deactivateCurrentActiveTag(
      CollectionReference tagCollection) async {
    final activeTagQuery = tagCollection.where('active', isEqualTo: true);
    final activeTagSnapshot = await activeTagQuery.limit(1).get();

    if (activeTagSnapshot.docs.isNotEmpty) {
      final activeTagDocId = activeTagSnapshot.docs.first.id;
      final activeTagDocReference = tagCollection.doc(activeTagDocId);
      await activeTagDocReference.update({'active': false});
    }
  }

  Future<void> _activateNewTag(
      CollectionReference tagCollection, Tag newTag) async {
    final newTagQuery = tagCollection.where('name', isEqualTo: newTag.name);
    final newTagSnapshot = await newTagQuery.limit(1).get();

    if (newTagSnapshot.docs.isNotEmpty) {
      final newTagDocId = newTagSnapshot.docs.first.id;
      final newTagDocReference = tagCollection.doc(newTagDocId);
      await newTagDocReference.update({'active': true});
    }
  }

  Future<void> fetchTags() async {
    final items = await fetchList<Tag, Tag>(Tag(), FirebaseCollections.tag);
    state = state.copyWith(tags: items);
    _fullTagList = items ?? [];
  }

  Future<void> fetchRecommended() async {
    final recommended = await fetchList<Recommended, Recommended>(
        Recommended(), FirebaseCollections.recommended);
    state = state.copyWith(recommended: recommended);
  }
}

class HomeState extends Equatable {
  final List<News>? news;
  final List<Tag>? tags;
  final List<Recommended>? recommended;
  final bool? isLoading;
  final Tag? selectedTag;

  HomeState({
    this.news,
    this.tags,
    this.recommended,
    this.isLoading,
    this.selectedTag,
  });
  @override
  List<Object?> get props => [news, tags, recommended, isLoading, selectedTag];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    List<Recommended>? recommended,
    bool? isLoading,
  }) {
    return HomeState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      recommended: recommended ?? this.recommended,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

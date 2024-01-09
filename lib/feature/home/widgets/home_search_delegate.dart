import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/models/tag_model.dart';

class HomeSearchDelegate extends SearchDelegate<Tag?> {
  final List<Tag> listItems;

  HomeSearchDelegate(this.listItems);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
        tooltip: 'Clear',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = listItems.where(
        (element) => element.name?.toLowerCase().contains(query) ?? false);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Text(results.elementAt(index).name ?? ''),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = listItems.where(
        (element) => element.name?.toLowerCase().contains(query) ?? false);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () => close(context, results.elementAt(index)),
            title: Text(results.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }
}

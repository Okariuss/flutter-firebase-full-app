import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/utility/exceptions/firebase_custom_exception.dart';
import 'package:kartal/kartal.dart';

import '../../product/models/news_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _HomeListView(),
    );
  }
}

class _HomeListView extends StatelessWidget {
  const _HomeListView();

  @override
  Widget build(BuildContext context) {
    CollectionReference news = FirebaseFirestore.instance.collection('news');

    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) throw FirebaseCustomException('$value not null');
        ;
        return value.toJson();
      },
    ).get();
    return FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Placeholder();
          case ConnectionState.waiting:
          case ConnectionState.active:
            return LinearProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              final values = snapshot.data!.docs.map((e) => e.data()).toList();

              return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            values[index].backgroundImage ?? '',
                            height: context.sized.dynamicHeight(.1),
                          ),
                          Text(values[index].title ?? '',
                              style: context.general.textTheme.labelLarge),
                        ],
                      ),
                    );
                  });
            } else {
              return SizedBox();
            }
        }
      },
    );
  }
}

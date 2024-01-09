part of '../home_view.dart';

class _HomeListView extends StatelessWidget {
  const _HomeListView();

  @override
  Widget build(BuildContext context) {
    final news = FirebaseCollections.news.reference;
    final response = news.withConverter(fromFirestore: (snapshot, options) {
      return News().fromFirebase(snapshot);
    }, toFirestore: (value, options) {
      return value.toJson();
    }).get();
    return FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Placeholder();
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const LinearProgressIndicator();
          case ConnectionState.done:
            if (snapshot.hasData) {
              final values = snapshot.data!.docs.map((e) => e.data()).toList();
              return ListView.builder(
                itemCount: values.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          values[index].backgroundImage ?? '',
                          height: context.sized.dynamicHeight(.1),
                        ),
                        Text(
                          values[index].title ?? '',
                          style: context.general.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
        }
      },
    );
  }
}

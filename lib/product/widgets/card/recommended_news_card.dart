part of '../../../feature/home/home_view.dart';

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
    required this.recommendedItem,
  });

  final Recommended? recommendedItem;

  @override
  Widget build(BuildContext context) {
    if (recommendedItem == null) return const SizedBox.shrink();
    return Padding(
      padding: context.padding.normal,
      child: Row(
        children: [
          Image.network(
            recommendedItem!.image ?? '',
            height: ImageSize.normal.value.toDouble(),
          ),
          Expanded(
            child: ListTile(
              title: Text(recommendedItem!.title ?? ''),
              subtitle: Text(recommendedItem!.description ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}

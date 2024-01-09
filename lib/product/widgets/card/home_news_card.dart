part of '../../../feature/home/home_view.dart';

class _HomeNewsCard extends StatelessWidget {
  const _HomeNewsCard({
    required this.newsItem,
  });

  final News? newsItem;

  @override
  Widget build(BuildContext context) {
    if (newsItem == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: Image.network(
            newsItem!.backgroundImage ?? '',
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.padding.horizontalNormal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    color: ColorConstants.white,
                    size: WidgetSize.iconNormal.value.toDouble(),
                  ),
                ),
                Padding(
                  padding: context.padding.onlyBottomMedium,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsItem!.category ?? '',
                        style: context.general.textTheme.labelMedium?.copyWith(
                          color: ColorConstants.greyLighter,
                        ),
                      ),
                      Padding(
                        padding: context.padding.onlyTopLow,
                        child: Text(
                          newsItem!.title ?? '',
                          style: context.general.textTheme.bodyLarge
                              ?.copyWith(color: ColorConstants.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

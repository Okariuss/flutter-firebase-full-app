part of '../home_view.dart';

class _ActiveChip extends StatelessWidget {
  const _ActiveChip({required this.tag, required this.provider});

  final Tag? tag;
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    if (tag == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () async {
        await provider.changeTagActiveStatus(tag!);
      },
      child: Chip(
        label: Text(
          tag?.name ?? '',
          style: context.general.textTheme.bodySmall
              ?.copyWith(color: ColorConstants.white),
        ),
        backgroundColor: ColorConstants.purplePrimary,
        padding: context.padding.verticalLow + context.padding.horizontalMedium,
      ),
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip({required this.tag, required this.provider});

  final Tag? tag;
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    if (tag == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () async {
        await provider.changeTagActiveStatus(tag!);
      },
      child: Chip(
        label: Text(
          tag?.name ?? '',
          style: context.general.textTheme.bodySmall
              ?.copyWith(color: ColorConstants.greyPrimary),
        ),
        backgroundColor: ColorConstants.greyLighter,
        padding: context.padding.verticalLow + context.padding.horizontalMedium,
      ),
    );
  }
}

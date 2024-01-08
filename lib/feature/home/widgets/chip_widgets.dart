part of '../home_view.dart';

class _ActiveChip extends StatelessWidget {
  const _ActiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'label active',
        style: context.general.textTheme.bodySmall
            ?.copyWith(color: ColorConstants.white),
      ),
      backgroundColor: ColorConstants.purplePrimary,
      padding: context.padding.verticalLow + context.padding.horizontalMedium,
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'label passive',
        style: context.general.textTheme.bodySmall
            ?.copyWith(color: ColorConstants.greyPrimary),
      ),
      backgroundColor: ColorConstants.greyLighter,
      padding: context.padding.verticalLow + context.padding.horizontalMedium,
    );
  }
}

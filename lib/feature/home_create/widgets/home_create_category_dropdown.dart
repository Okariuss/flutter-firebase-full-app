part of '../home_create_view.dart';

class _HomeCreateCategoryDropDown extends StatelessWidget {
  const _HomeCreateCategoryDropDown({
    required this.categories,
    required this.onSelected,
  });

  final List<Category> categories;
  final ValueSetter<Category> onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Category>(
      validator: (value) =>
          value == null ? StringConstants.selectCategory : null,
      items: categories
          .map((e) => DropdownMenuItem<Category>(
                value: e,
                child: Text(e.name ?? ''),
              ))
          .toList(),
      hint: Text(StringConstants.selectCategory),
      onChanged: (value) {
        if (value != null) return;
        onSelected.call(value!);
      },
    );
  }
}

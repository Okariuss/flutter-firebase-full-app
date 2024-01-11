import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/home_create/mixins/home_create_mixin.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:flutter_firebase_full_app/product/enums/index.dart';
import 'package:kartal/kartal.dart';

import '../../product/models/category_model.dart';

part 'widgets/empty_sized_box.dart';
part 'widgets/home_create_category_dropdown.dart';

class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});

  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView>
    with HomeCreateMixin, Loading {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(StringConstants.addNewItem),
          centerTitle: false,
          actions: [
            if (isLoading)
              Center(
                child: const CircularProgressIndicator(
                  color: ColorConstants.white,
                ),
              )
          ]),
      body: Form(
        key: homeLogic.formKey,
        onChanged: () {
          homeLogic.checkValidateAndSave((value) {
            setState(() {});
          });
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: context.padding.low,
          child: ListView(
            children: [
              _HomeCreateCategoryDropDown(
                categories: homeLogic.categories,
                onSelected: homeLogic.updateCategory,
              ),
              _EmptySizedBox(),
              TextFormField(
                controller: homeLogic.titleController,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Not Empty' : null,
                decoration: InputDecoration(
                    hintText: StringConstants.title,
                    border: OutlineInputBorder()),
              ),
              _EmptySizedBox(),
              InkWell(
                onTap: () async {
                  await homeLogic.pickAndCheck((value) {
                    setState(() {});
                  });
                },
                child: SizedBox(
                  height: context.sized.dynamicHeight(0.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.greyPrimary),
                    ),
                    child: homeLogic.selectedFileBytes != null
                        ? Image.memory(homeLogic.selectedFileBytes!)
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              _EmptySizedBox(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(
                      WidgetSize.buttonNormal.value.toDouble(),
                    ),
                  ),
                  onPressed: !homeLogic.isValidateAllForm
                      ? null
                      : () async {
                          changeLoading();
                          final response = await homeLogic.save();
                          changeLoading();
                          if (!mounted) return;
                          context.route.pop<bool>(response);
                        },
                  icon: Icon(Icons.send),
                  label: Text(StringConstants.send))
            ],
          ),
        ),
      ),
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}

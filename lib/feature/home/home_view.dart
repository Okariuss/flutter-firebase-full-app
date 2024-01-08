import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:flutter_firebase_full_app/product/enums/index.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/subtitle_text.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/title_text.dart';
import 'package:kartal/kartal.dart';

part './widgets/chip_widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: context.padding.normal,
          child: ListView(
            children: [
              _Header(),
              _CustomField(),
              _TagListView(),
              _BrowseHorizontalListView(),
              _RecommendedHeader(),
              _RecommendedListView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  const _CustomField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: IconConstants.microphone.toImage,
        suffixIconColor: ColorConstants.greyPrimary,
        prefixIcon: IconConstants.search.toImage,
        prefixIconColor: ColorConstants.greyPrimary,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: ColorConstants.greyLighter,
        hintText: StringConstants.homeSearchHint,
      ),
    );
  }
}

class _TagListView extends StatelessWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return _PassiveChip();
          }
          return _ActiveChip();
        },
      ),
    );
  }
}

class _BrowseHorizontalListView extends StatelessWidget {
  const _BrowseHorizontalListView();

  static const dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-news-47520.appspot.com/o/house.png?alt=media&token=4e1a9e3d-fd8c-4085-b256-08e9bade72d9';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.3),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _HorizontalCard(dummyImage: dummyImage);
        },
      ),
    );
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.dummyImage,
  });

  final String dummyImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: Image.network(_BrowseHorizontalListView.dummyImage),
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
                        'POLITICS',
                        style: context.general.textTheme.labelMedium?.copyWith(
                          color: ColorConstants.greyLighter,
                        ),
                      ),
                      Padding(
                        padding: context.padding.onlyTopLow,
                        child: Text(
                          'The latest situation in the presidential election',
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

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleText(value: StringConstants.homeRecommended),
        TextButton(
            onPressed: () {},
            child: SubtitleText(value: StringConstants.homeSeeAll)),
      ],
    );
  }
}

class _RecommendedListView extends StatelessWidget {
  const _RecommendedListView();

  static const dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-news-47520.appspot.com/o/simple_trick.png?alt=media&token=fd069490-75bc-47e0-9315-8c74db875813';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _RecommendedCard(dummyImage: dummyImage);
      },
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
    required this.dummyImage,
  });

  final String dummyImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: Row(
        children: [
          Image.network(
            _RecommendedListView.dummyImage,
            height: ImageSize.normal.value.toDouble(),
          ),
          Expanded(
            child: ListTile(
              title: Text('UI/UX Design'),
              subtitle:
                  Text('A Simple Trick For Creating Color Palettes Quickly'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(value: StringConstants.homeBrowse),
        Padding(
          padding: context.padding.onlyTopLow,
          child: SubtitleText(value: StringConstants.homeDiscover),
        ),
      ],
    );
  }
}

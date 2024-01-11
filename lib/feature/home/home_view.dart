import 'package:flutter/material.dart';
import 'package:flutter_firebase_full_app/feature/home/home_provider.dart';
import 'package:flutter_firebase_full_app/feature/home/widgets/home_search_delegate.dart';
import 'package:flutter_firebase_full_app/feature/home_create/home_create_view.dart';
import 'package:flutter_firebase_full_app/product/constants/index.dart';
import 'package:flutter_firebase_full_app/product/enums/index.dart';
import 'package:flutter_firebase_full_app/product/models/news_model.dart';
import 'package:flutter_firebase_full_app/product/models/recommended_model.dart';
import 'package:flutter_firebase_full_app/product/models/tag_model.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/subtitle_text.dart';
import 'package:flutter_firebase_full_app/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kartal/src/widget/route/slide_route.dart';

part '../../product/widgets/card/home_news_card.dart';
part '../../product/widgets/card/recommended_news_card.dart';
part 'widgets/home_chip_widgets.dart';
part 'widgets/home_news_list_view.dart';

final _homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider();
});

class HomeView extends ConsumerStatefulWidget {
  HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchAndLoad();
    });
    ref.read(_homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _textController.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await context.route.navigateToPage<bool?>(
            HomeCreateView(),
            type: SlideType.LEFT,
          );
          if (response ?? false) {
            ref.read(_homeProvider.notifier).fetchAndLoad();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.padding.normal,
          child: Stack(
            children: [
              ListView(
                children: [
                  _Header(),
                  _CustomField(_textController),
                  _TagListView(),
                  _BrowseHorizontalListView(),
                  _RecommendedHeader(),
                  _RecommendedListView(),
                  // _HomeListView(),
                ],
              ),
              if (ref.watch(_homeProvider).isLoading ?? false)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomField extends ConsumerWidget {
  _CustomField(this._controller);
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
            context: context,
            delegate: HomeSearchDelegate(
              ref.watch(_homeProvider).tags ?? [],
            ));
        ref.watch(_homeProvider.notifier).changeTagActiveStatus(response!);
      },
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

class _TagListView extends ConsumerWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(_homeProvider.notifier);
    final tags = ref.watch(_homeProvider).tags;
    return SizedBox(
      height: context.sized.dynamicHeight(.1),
      child: ListView.builder(
        itemCount: tags?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (tags?[index].active ?? false) {
            return _ActiveChip(tag: tags?[index], provider: provider);
          }
          return _PassiveChip(
            tag: tags?[index],
            provider: provider,
          );
        },
      ),
    );
  }
}

class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(_homeProvider).news;
    return SizedBox(
      height: context.sized.dynamicHeight(.3),
      child: ListView.builder(
        itemCount: news?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _HomeNewsCard(
            newsItem: news?[index],
          );
        },
      ),
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

class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommended = ref.watch(_homeProvider).recommended;

    return ListView.builder(
      itemCount: recommended?.length ?? 0,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _RecommendedCard(
          recommendedItem: recommended?[index],
        );
      },
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

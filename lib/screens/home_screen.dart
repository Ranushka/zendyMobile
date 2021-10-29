import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/controllers/controllers.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: Theme.of(Get.context).backgroundColor,
      appBar: emptyAppbar(),
      body: Container(
        child: SingleChildScrollView(
          child: _buildMainContent(),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget _buildMainContent() {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroCall(),
        _buildDumySearchInput(),
        SizedBox(height: 8),
        LatestNewsList(),
        // _buildLatustNewsList(),
        _buildJoinZendyPlus(),
        _buildFromOurBlog(),
        SizedBox(height: 32),
      ],
      direction: Axis.vertical,
    );
  }

  Widget _buildHeroCall() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          _buildUserGreating(),
          SizedBox(height: 16),
          Gutter(Title1('Research is creating new knowledge.')),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildUserGreating() {
    return Obx(() {
      if (authController.currentUser.value.firstName != '')
        return Gutter(
          Title3('G, day ${authController.currentUser.value.firstName}'),
        );
      else
        return Gutter(Title3('Welcome to Zendy'));
    });
  }

  Widget _buildJoinZendyPlus() {
    return Obx(() {
      if (authController.currentUser.value.firstName == '') {
        return Gutter(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(Get.context).primaryColorLight,
          ),
          child: Gutter(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Title2('Join Zendy plus'),
              SizedBox(height: 16),
              TextBody(
                  'Create free account and enjoy Zendy plus and the feacthers comes with it.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Learn more'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text('Create account'),
                    onPressed: () {
                      Get.toNamed(Goto.login);
                    },
                  ),
                ],
              ),
            ],
          )),
        ));
      }
      return Container();
    });
  }

  Widget _buildLatustNewsList() {
    _content() {
      return Gutter(Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetTitleAction('Curated just for you', () {}),
          _buildLatustNews(),
          _buildLatustNews(),
          _buildLatustNews(),
        ],
      ));
    }

    final sc = Gutter(
      Column(
        children: [
          Skeleton(),
          SizedBox(height: 8),
          Skeleton(),
          SizedBox(height: 8),
          Skeleton(),
          SizedBox(height: 8),
        ],
      ),
    );

    return Obx(() {
      if (productController.isLoading.value)
        return sc;
      else
        return _content();
    });
  }

  Widget _buildFromOurBlog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8),
        Gutter(WidgetTitleAction('From our blog', () {})),
        SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16),
              _buildBlogNewsItem(),
              _buildBlogNewsItem(),
              _buildBlogNewsItem(),
              SizedBox(width: 16),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBlogNewsItem() {
    return Container(
      width: Get.width * 0.8,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        // clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/id/237/300/200'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Title3('Card title 1'),
                  SizedBox(height: 8),
                  TextBody(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatustNews() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Title5('Elsevier - Journal'),
                  SizedBox(height: 4),
                  Title3('Debut Novelists and Women Dominate'),
                  SizedBox(height: 4),
                  TextBody(
                    'Some literary heavy hitters missed out, including Hilary Mantel, whose latest work, “The Mirror and the Light,” did not make the cut',
                    ml: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDumySearchInput() {
    return Container(
      color: Colors.white,
      child: Gutter(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: TextFormField(
            autofocus: false,
            onTap: () {
              Get.toNamed(Goto.search);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context).primaryColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context).primaryColor,
                  width: 1.5,
                ),
              ),
              suffixIcon: _buildSearchIcon(),
              hintText: 'Search for title, subject, author ...',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      splashRadius: 28,
      color: Theme.of(Get.context).primaryColor,
      icon: Icon(Icons.search_rounded),
      onPressed: () => {Get.toNamed(Goto.search)},
    );
  }
}

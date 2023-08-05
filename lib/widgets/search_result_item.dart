import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'package:zendy/widgets/widgets.dart';
import 'package:zendy/controllers/controllers.dart';
import 'package:zendy/helpers/helpers.dart';

class SearchResultItem extends StatelessWidget {
  final String _id;
  final dynamic _item;

  const SearchResultItem(this._id, this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool isFullDetail = false.obs;
    final abstract = _item['abstract']?.trim();
    // print(_item.downloadLink + '---' + _item.zendyLink);
    var zendyLink = _item['downloadLink'] ?? '';

    return Container(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildTitle(
              _item['title'],
              _item['publicationYear'],
              _item['publicationType'],
              _item['publicationName'],
            ),
            if (abstract != null)
              if (isFullDetail.value)
                _buildFullContent(abstract, isFullDetail)
              else
                _buildShortContent(abstract, isFullDetail),
            _actionsBar(isFullDetail, zendyLink!, _item['title'], _id),
          ],
        );
      }),
    );
  }

  Widget _actionsBar(
    isFullDetail,
    String zendyLink,
    String title,
    String id,
  ) {
    return Container(
        alignment: const Alignment(-40, -100),
        child: Gutter(
          ButtonBar(
            buttonPadding: const EdgeInsets.all(0),
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    iconSize: 20,
                    splashRadius: 24,
                    icon: const Icon(FontIcons.share),
                    onPressed: () {
                      Share.share(
                        'Zendy Reserch link ${Goto.baseUrl}$zendyLink',
                        subject: 'Reserch title',
                      );
                    },
                  ),
                  IconButton(
                    iconSize: 20,
                    splashRadius: 24,
                    icon: const Icon(FontIcons.cite),
                    onPressed: () {
                      citationPopup();
                    },
                  ),
                  IconButton(
                    iconSize: 20,
                    splashRadius: 24,
                    icon: const Icon(FontIcons.paper_add),
                    onPressed: () {
                      LibraryController().saveData({
                        'permanentLinkId': _item['permanentLinkId'],
                        'title': title,
                        'publicationYear': _item['publicationYear'],
                        'publicationType': _item['publicationType'],
                        'publicationName': _item['publicationName'],
                        'readLink': _item['zendyLink'],
                        'downloadLink': _item['downloadLink'],
                      });
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  goToWebPage(_item['zendyLink'], _item['downloadLink']);
                },
                child: const Text('Read full'),
              ),
            ],
          ),
        ));
  }

  Widget _actionsReadMore(isFullDetail) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        isFullDetail.value = !isFullDetail.value;
      },
      child: Gutter(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: isFullDetail.value ? 32 : 16,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(Get.context!)
                      .colorScheme
                      .background
                      .withOpacity(0.6),
                  Theme.of(Get.context!).colorScheme.background,
                ],
              )),
              // color: Theme.of(Get.context!).backgroundColor.withOpacity(0.6),
              width: double.infinity,
            ),
            Transform.translate(
              offset: const Offset(0, 1),
              child: Container(
                height: 16,
                color: Theme.of(Get.context!).colorScheme.background,
                width: 32,
                child: Transform.rotate(
                  angle: isFullDetail.value ? 3.2 : 0,
                  child: const Icon(FontIcons.curt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title, String year, pubType, pubTitle) {
    final List<String> parts = [];

    if (pubType.isNotEmpty) parts.add(titleCase(pubType));
    if (year.isNotEmpty) parts.add(year);
    if (pubTitle.isNotEmpty) parts.add(pubTitle);

    final String subtitle = parts.join(' - ');

    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => goToWebPage(_item['zendyLink'], _item['downloadLink']),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Gutter(TextSmall(subtitle)),
          const SizedBox(height: 8),
          Gutter(HtmlH3(title)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildShortContent(abstract, isFullDetail) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        isFullDetail.value = true;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: HtmlP(abstract, true),
          ),
          _actionsReadMore(isFullDetail),
        ],
      ),
    );
  }

  Widget _buildFullContent(String data, isFullDetail) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAbstract(_item['abstract']),
            _buildAuthorsList(_item['authors']),
            _buildKeyWords(_item['keywords']),
            _buildSubjectsList(_item['subjects']),
            isFullDetail.value ? const SizedBox(height: 32) : Container(),
          ],
        ),
        const SizedBox(height: 32),
        _actionsReadMore(isFullDetail),
      ],
    );
  }

  Widget _buildKeyWords(String? data) {
    if (data == null || data.isEmpty) return Container();
    var data0 = data.split(',');

    return Gutter(
      Column(children: [
        Wrap(children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Title4('Keywords'),
          ),
          ...data0.map((itm) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                highlightColor: Colors.transparent,
                splashColor: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 4),
                  child: TextBody(itm.trim(), link: true),
                ),
                onTap: () {},
              ),
            );
          }),
        ]),
        const SizedBox(height: 16, width: 16),
      ]),
    );
  }

  Widget _buildSubjectsList(List? data) {
    if (data == null || data.isEmpty) return Container();

    return Gutter(Wrap(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Title4('Subjects'),
        ),
        ...data.map((itm) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              highlightColor: Colors.transparent,
              splashColor: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                child: TextBody(itm.trim(), link: true),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  Widget _buildAbstract(String? data) {
    if (data == null) return Container();

    return Gutter(Wrap(
      children: [
        HtmlP(data),
        const SizedBox(height: 16, width: 16),
      ],
    ));
  }

  Widget _buildAuthorsList(List? data) {
    if (data == null || data.isEmpty) return Container();

    return Gutter(
      Column(children: [
        Wrap(children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Title4('Authors'),
          ),
          ...data.map((itm) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                highlightColor: Colors.transparent,
                splashColor: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 4),
                  child: TextBody(itm.trim(), link: true),
                ),
              ),
            );
          }),
        ]),
        const SizedBox(height: 16, width: 16),
      ]),
    );
  }
}

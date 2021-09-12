import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'package:zendy_app/widgets/widgets.dart';
import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/models/search_model.dart';
import 'typography.dart';

class SearchResultItem extends StatelessWidget {
  final String _id;
  final SearchModelResultItem _item;

  const SearchResultItem(this._id, this._item);

  @override
  Widget build(BuildContext context) {
    final RxBool _isFullDetail = false.obs;
    final _abstract = _item.resultAbstract?.trim();
    var _zendyLink = _item.downloadLink ?? _item.zendyLink;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            _buildTitle(_item.title, _item.publicationYear, _zendyLink),
            if (_abstract != null)
              if (_isFullDetail.value)
                _buildFullContent(_abstract)
              else
                _buildShortContent(_abstract, _isFullDetail),
            _actionsBar(_isFullDetail, _zendyLink, _item.title, _id),
          ],
        );
      }),
    );
  }

  Widget _actionsBar(
    _isFullDetail,
    String _zendyLink,
    String _title,
    String _id,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 4,
            offset: Offset(0, -2), // Shadow position
          ),
        ],
      ),
      child: ButtonBar(
        buttonPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                splashRadius: 24,
                icon: Icon(CusIcons.share_outline),
                onPressed: () {
                  Share.share(
                    'Zendy Reserch link ${Goto.baseUrl}$_zendyLink',
                    subject: 'Reserch title',
                  );
                },
              ),
              IconButton(
                splashRadius: 24,
                icon: Icon(CusIcons.cite_outline),
                onPressed: () {
                  SavedCitationsController().saveData(_title, _zendyLink, _id);
                },
              ),
              IconButton(
                splashRadius: 24,
                icon: Icon(CusIcons.logout_outline),
                onPressed: () {},
              ),
            ],
          ),
          if (_isFullDetail.value)
            ElevatedButton(
              onPressed: () {
                print('>>>>zendyLink>>>>' + _item.zendyLink);
                print('>>>>downloadLink>>>>' + _item.downloadLink);
                Get.toNamed(
                  Goto.webPage,
                  arguments: _item.downloadLink.isBlank
                      ? _item.zendyLink
                      : _item.downloadLink,
                );
              },
              child: Text("Go to source"),
            )
          else
            TextButton(
              onPressed: () {
                _isFullDetail.value = true;
              },
              child: const Text('Read more'),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle(String _title, int _year, String _zendyLink) {
    return InkWell(
      focusColor: c.transparent,
      highlightColor: c.transparent,
      splashColor: c.transparent,
      onTap: () {
        print('>>>>_sourceLink>>>>' + _zendyLink);

        Get.toNamed(
          Goto.webPage,
          arguments: _zendyLink,
        );
      },
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Gutter(Title4('Journal - $_year - ${_linkType()}')),
          SizedBox(height: 8),
          Gutter(HtmlH3(_title)),
          // HtmlH3(_title),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildShortContent(_abstract, _isFullDetail) {
    return InkWell(
      focusColor: c.transparent,
      highlightColor: c.transparent,
      splashColor: c.transparent,
      onTap: () {
        _isFullDetail.value = true;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: HtmlP(_abstract, true),
        // child: Text(
        //   _abstract,
        //   maxLines: 4,
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
        // ),
      ),
    );
  }

  Widget _buildFullContent(String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_item.resultAbstract != null) Gutter(HtmlP(_item.resultAbstract)),
        SizedBox(height: 16),
        if (_item.authors != null) _buildAuthorsList(_item.authors),
        SizedBox(height: 16),
        if (_item.keywords != null) _buildKeyWords(_item.keywords),
        SizedBox(height: 16),
        if (_item.subjects != null) _buildSubjectsList(_item.subjects),
      ],
    );
  }

  Widget _buildKeyWords(String data) {
    var _data = data.split(',');

    // print('=====>>>>>' + _data.length.toString());

    if (_data[0] == '') {
      return Container();
    }

    return Gutter(Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Title4('Keywords'),
        ),
        ..._data.map((_itm) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              highlightColor: Colors.transparent,
              splashColor: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                child: new LinkText(_itm.trim()),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  Widget _buildSubjectsList(String data) {
    var _data = data.split(',');

    return Gutter(Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Title4('Subjects'),
        ),
        ..._data.map((_itm) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              highlightColor: Colors.transparent,
              splashColor: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                child: new LinkText(_itm.trim()),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  Widget _buildAuthorsList(String data) {
    var _data = data.split(',');

    return Gutter(Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Title4('Authors'),
        ),
        ..._data.map((_itm) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              highlightColor: Colors.transparent,
              splashColor: Colors.blue.shade100,
              child: Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                child: LinkText(_itm.trim()),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  String _linkType() {
    final url = _item.downloadLink;
    if (RegExp(r'.+\.pdf$').hasMatch(url)) {
      return 'PDF';
    }
    return 'URL';
  }
}

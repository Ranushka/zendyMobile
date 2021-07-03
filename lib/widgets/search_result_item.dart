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
    final _abstract = _item.bibjsonAbstract?.trim();
    var _zendyLink = Goto.title + _id;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            _buildTitle(_item.title, _item.year, _zendyLink, _item.link[0].url),
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
    return ButtonBar(
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
              Get.toNamed(
                Goto.webPage,
                arguments: _item.link[0].url,
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
    );
  }

  Widget _buildTitle(
    String _title,
    String _year,
    String _zendyLink,
    String _sourceLink,
  ) {
    return InkWell(
      focusColor: c.transparent,
      highlightColor: c.transparent,
      splashColor: c.transparent,
      onTap: () {
        Get.toNamed(
          Goto.webPage,
          arguments: _sourceLink,
        );
      },
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Gutter(Title4('Journal - ${_year.trim()} - ${_linkType()}')),
          SizedBox(height: 8),
          Gutter(Title3(_title.trim())),
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
        child: Text(
          _abstract,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
      ),
    );
  }

  Widget _buildFullContent(String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_item.bibjsonAbstract != null)
          Gutter(
            Text(
              _item.bibjsonAbstract,
              overflow: TextOverflow.fade,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        SizedBox(height: 16),
        if (_item.author != null) _buildAuthorsList(_item.author),
        SizedBox(height: 16),
        if (_item.keywords != null) _buildKeyWords(_item.keywords),
        SizedBox(height: 16),
        if (_item.subject != null) _buildSubjectsList(_item.subject),
      ],
    );
  }

  Widget _buildKeyWords(_data) {
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

  Widget _buildSubjectsList(_data) {
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
                child: new LinkText(_itm.term.trim()),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  Widget _buildAuthorsList(_data) {
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
                child: LinkText(_itm.name.trim()),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  String _linkType() {
    final url = _item.link[0].url;
    if (RegExp(r'.+\.pdf$').hasMatch(url)) {
      return 'PDF';
    }
    return 'URL';
  }
}

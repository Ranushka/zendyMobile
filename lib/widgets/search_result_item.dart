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
    print(_item.downloadLink + '---' + _item.zendyLink);
    var _zendyLink = _item.downloadLink ?? _item.zendyLink;

    return Container(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            _buildTitle(_item.title, _item.publicationYear),
            if (_abstract != null)
              if (_isFullDetail.value)
                _buildFullContent(_abstract, _isFullDetail)
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
        alignment: const Alignment(-40, -100),
        child: Gutter(
          ButtonBar(
            buttonPadding: const EdgeInsets.all(0),
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    icon: Icon(CusIcons.share),
                    onPressed: () {
                      Share.share(
                        'Zendy Reserch link ${Goto.baseUrl}$_zendyLink',
                        subject: 'Reserch title',
                      );
                    },
                  ),
                  IconButton(
                    splashRadius: 24,
                    icon: Icon(CusIcons.cite),
                    onPressed: () {
                      citationPopup();
                    },
                  ),
                  IconButton(
                    splashRadius: 24,
                    icon: Icon(CusIcons.paper_add),
                    onPressed: () {
                      SavedCitationsController().saveData(
                        _title,
                        _item.zendyLink,
                        _item.downloadLink,
                        _id,
                      );
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () => _goToWebPage(),
                child: const Text('Read full'),
              ),
            ],
          ),
        ));
  }

  Widget _actionsReadMore(_isFullDetail) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _isFullDetail.value = !_isFullDetail.value;
      },
      child: Gutter(
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: _isFullDetail.value ? 32 : 16,
              color: Theme.of(Get.context).backgroundColor.withOpacity(0.6),
              width: double.infinity,
            ),
            Transform.translate(
              offset: const Offset(0, 1),
              child: Container(
                height: 16,
                color: Theme.of(Get.context).backgroundColor,
                width: 32,
                child: _isFullDetail.value
                    ? Icon(Icons.arrow_drop_up_rounded)
                    : Icon(Icons.arrow_drop_down_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String _title, int _year) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => _goToWebPage(),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Gutter(TextSmall('Journal - $_year - ${_item.journalTitle}')),
          SizedBox(height: 8),
          Gutter(HtmlH3(_title)),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildShortContent(_abstract, _isFullDetail) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _isFullDetail.value = true;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: HtmlP(_abstract, true),
          ),
          _actionsReadMore(_isFullDetail),
        ],
      ),
    );
  }

  Widget _buildFullContent(String data, _isFullDetail) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAbstract(_item.resultAbstract),
            _buildAuthorsList(_item.authors),
            _buildKeyWords(_item.keywords),
            _buildSubjectsList(_item.subjects),
            SizedBox(height: 16),
          ],
        ),
        _actionsReadMore(_isFullDetail),
      ],
    );
  }

  Widget _buildKeyWords(String data) {
    if (data == null || data == '' || data[0] == '') return Container();
    var _data = data.split(',');

    return Gutter(
      Column(children: [
        Wrap(children: [
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
                  child: new TextBody(_itm.trim(), link: true),
                ),
                onTap: () {},
              ),
            );
          }),
        ]),
        SizedBox(height: 16, width: 16),
      ]),
    );
  }

  Widget _buildSubjectsList(String data) {
    if (data == null) return Container();
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
                child: new TextBody(_itm.trim(), link: true),
              ),
              onTap: () {},
            ),
          );
        })
      ],
    ));
  }

  Widget _buildAbstract(String data) {
    if (data == null) return Container();

    return Gutter(Wrap(
      children: [
        HtmlP(_item.resultAbstract),
        SizedBox(height: 16, width: 16),
      ],
    ));
  }

  Widget _buildAuthorsList(String data) {
    if (data == null) return Container();
    var _data = data.split(',');

    return Gutter(
      Column(children: [
        Wrap(children: [
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
                  child: TextBody(_itm.trim(), link: true),
                ),
              ),
            );
          }),
        ]),
        SizedBox(height: 16, width: 16),
      ]),
    );
  }

  String _linkType() {
    final url = _item.downloadLink;
    if (RegExp(r'.+\.pdf$').hasMatch(url)) {
      return 'PDF';
    }
    return 'URL';
  }

  _goToWebPage() {
    final AuthController authCtrl = Get.find();

    if (authCtrl.isLoggedIn()) {
      Get.toNamed(
        Goto.webPage,
        arguments: {
          'read': _item.zendyLink,
          'download': _item.downloadLink,
        },
      );
    } else {
      loginToProceed();
    }
  }
}

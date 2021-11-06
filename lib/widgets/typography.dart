import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String titleCase() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class HtmlH3 extends StatelessWidget {
  final String _text;
  const HtmlH3(this._text);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      '<div>${_text.titleCase()}</div>',
      textStyle: Theme.of(context).textTheme.headline3,
    );
  }
}

class HtmlP extends StatelessWidget {
  final String _text;
  final bool _isShort;
  const HtmlP(this._text, [this._isShort = false]);

  @override
  Widget build(BuildContext context) {
    var _mHeight = _isShort ? "max-height:84px" : "";

    return HtmlWidget(
      '<div style=" $_mHeight">$_text</div>',
      textStyle: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class Title1 extends StatelessWidget {
  final String _text;
  const Title1(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class Title2 extends StatelessWidget {
  final String _text;
  const Title2(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class Title3 extends StatelessWidget {
  final String _text;
  final int ml;
  const Title3(this._text, {this.ml = 6});

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline3,
      maxLines: ml,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class Title4 extends StatelessWidget {
  final String _text;
  const Title4(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class TextBody extends StatelessWidget {
  final String _text;
  final int ml;
  final bool link;

  TextBody(this._text, {this.ml = 1000, this.link = false});

  @override
  Widget build(BuildContext context) {
    TextStyle themeStyle = Theme.of(context).textTheme.bodyText1;

    return Text(
      _text,
      maxLines: ml,
      overflow: TextOverflow.ellipsis,
      style: themeStyle.copyWith(color: link ? Colors.blue : themeStyle.color),
    );
  }
}

class TextSmall extends StatelessWidget {
  final String _text;
  const TextSmall(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.subtitle1.copyWith(),
    );
  }
}

class BtnText extends StatelessWidget {
  final String _text;
  const BtnText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class Gutter extends StatelessWidget {
  final Widget _content;
  const Gutter(this._content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: _content,
    );
  }
}

Widget dividerX = Gutter(Divider(
  height: 1,
  color: Theme.of(Get.context).primaryColor.withOpacity(0.4),
));

class Skeleton extends StatelessWidget {
  final double height;

  const Skeleton({
    Key key,
    this.height = 104,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Colors.grey.withOpacity(0.1),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}

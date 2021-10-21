import 'package:flutter/material.dart';
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
    var _fColor = '#444';
    var _mHeight = _isShort ? "max-height:84px" : "";

    return HtmlWidget('<div style="color: $_fColor; $_mHeight">$_text</div>');
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
  const Title3(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline3,
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
      style: const TextStyle(
        color: Colors.black38,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class Title5 extends StatelessWidget {
  final String _text;
  const Title5(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text.toUpperCase(),
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 12,
        // fontWeight: FontWeight.w600,
      ),
    );
  }
}

class TextBody extends StatelessWidget {
  final String _text;
  final int ml;

  TextBody(this._text, {this.ml = 1000});

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      maxLines: ml,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.black54,
      ),
    );
  }
}

class SmallMute extends StatelessWidget {
  final String _text;
  const SmallMute(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(
        color: Colors.black45,
        // fontSize: 13,
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  final String _text;
  const LinkText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: const TextStyle(
        color: Colors.blue,
        // fontSize: 12,
      ),
    );
  }
}

class BtnText extends StatelessWidget {
  final String _text;
  // final bool _dark = false;
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

const DividerX = const Gutter(Divider(height: 0.5));

class Skeleton extends StatelessWidget {
  final double height;

  const Skeleton({
    Key key,
    this.height = 104,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Colors.white54,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

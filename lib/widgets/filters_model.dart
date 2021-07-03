import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy_app/widgets/widgets.dart';

Future filtersModel() {
  final dynamic _data = {
    "journalTitlFull": [
      {'name': "E3S Web of Conferences", 'count': 12, 'checked': false},
      {'name': "Agronomy", 'count': 7, 'checked': false},
      {'name': "BIO Web of Conferences", 'count': 7, 'checked': false},
      {'name': "Water", 'count': 3, 'checked': false},
    ],
    "publicationTypeFull": [
      {'name': "books", 'count': 59, 'checked': false},
      {'name': "journal-article", 'count': 58, 'checked': false},
      {'name': "News", 'count': 23, 'checked': false},
    ],
    "publishersFull": [
      {'name': "EDP Sciences", 'count': 18, 'checked': false},
      {'name': "MDPI AG", 'count': 16, 'checked': false},
      {'name': "Adam Mickiewicz University", 'count': 7, 'checked': false},
      {'name': "Japan on Water Environment", 'count': 2, 'checked': false},
    ],
    "subjectsFull": [
      {'name': "Agriculture", 'count': 12, 'checked': false},
      {'name': "Agronomy", 'count': 6, 'checked': false},
    ],
    "language": [
      {'name': "en", 'count': 57, 'checked': false},
      {'name': "ar", 'count': 6, 'checked': false},
    ]
  };

  return showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      return SafeArea(
        child: FractionallySizedBox(
          heightFactor: 0.9,
          child: CheckBoxInListView(_data),
        ),
      );
    },
  );
}

class CheckBoxInListView extends StatefulWidget {
  final dynamic _data;

  CheckBoxInListView(this._data);

  @override
  _CheckBoxInListViewState createState() => _CheckBoxInListViewState();
}

class _CheckBoxInListViewState extends State<CheckBoxInListView> {
  @override
  Widget build(BuildContext context) {
    final finalList = <Widget>[];
    var widData = widget._data;

    checkBoxRow(name, count, checked) {
      RxBool _isChecked = false.obs;
      return Obx(() {
        return CheckboxListTile(
          secondary: Text(count),
          title: Text(name),
          value: _isChecked.value,
          onChanged: (bool val) {
            _isChecked.value = val;
          },
        );
      });
    }

    widData.forEach((oneKey, oneValue) {
      finalList.add(Title4(oneKey));

      for (var inRow in oneValue) {
        var count = inRow['count'].toString();
        var name = inRow['name'].toString();
        var checked = inRow['checked'];

        finalList.add(checkBoxRow(name, count, checked));
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(),
        actions: [_buildClearFiltersBtn()],
        title: Title2('Filters'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: finalList,
      ),
    );
  }
}

Widget _buildBackButton() {
  return IconButton(
    splashRadius: 28,
    icon: Icon(Icons.arrow_drop_down_circle_outlined),
    onPressed: () => Get.back(),
  );
}

Widget _buildClearFiltersBtn() {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: TextButton(
      child: Text('Clear filters'),
      onPressed: () => Get.back(),
    ),
  );
}

class SimpleModel {
  String title;
  bool isChecked;

  SimpleModel(this.title, this.isChecked);
}

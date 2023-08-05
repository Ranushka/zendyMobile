import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  Future<List<String>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historyList = prefs.getStringList('searchHistory');
    return historyList ?? [];
  }

  Future<void> create(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historyList = prefs.getStringList('searchHistory');
    historyList ??= [];

    if (!historyList.contains(data)) {
      historyList.insert(0, data);
      await prefs.setStringList('searchHistory', historyList);
    }
  }

  Future<void> delete(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? historyList = prefs.getStringList('searchHistory');
    historyList ??= [];

    historyList.remove(data);
    await prefs.setStringList('searchHistory', historyList);
  }
}

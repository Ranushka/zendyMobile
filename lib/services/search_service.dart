import 'dart:convert';
import 'dart:math';
import 'package:zendy/models/search_model.dart';
import 'package:zendy/services/dio_client.dart';

class SearchService {
  final dio = getDioClient();

  Future<dynamic> getResults(
    List facetFilters,
    String searchQuery,
    int pageNumber,
  ) async {
    pageNumber ??= 1;
    facetFilters ??= List.empty();

    final dataSend = jsonEncode({
      "searchQuery": [
        {"term": searchQuery}
      ],
      "facetFilters": facetFilters,
      "dateFilters": {"start": "1000-1", "end": "2050-12"},
      "pageNumber": pageNumber
    });

    try {
      final response = await dio.post('/search/search', data: dataSend);

      if (response.statusCode == 200) {
        // final datass = json.decode(response.data['data']);
        // jsonDecode(response.data['data']);
        // return searchModelFromJson(response.data['data']);

        var bb = addRandomUrlAttribute(response.data['data']);
        return bb;
      } else {
        return null;
      }
    } catch (error) {
      print('Error in fetching search results: $error');
      return null;
    }
  }
}

Map<String, dynamic> addRandomUrlAttribute(Map<String, dynamic> responseData) {
  // Sample pool of URLs
  List<String> pdfPool = [
    'https://www.lancaster.ac.uk/fass/resources/sociology-online-papers/papers/sheller-automotive-emotions.pdf',
    'https://research.upjohn.org/cgi/viewcontent.cgi?article=1088&context=empl_research',
    'https://journals.aps.org/prl/pdf/10.1103/PhysRevLett.55.2471',
    'https://eprints.lancs.ac.uk/id/eprint/3439/1/drivercar_eprint.pdf',
    '',
    '',
    '',
    '',
    'https://cran.uni-muenster.de/web/packages/car/car.pdf',
    'http://www.physics.rutgers.edu/~dhv/pubs/local_copy/uspp_3.pdf',
  ];

  List<String> htmlPool = [
    'https://www.nature.com/articles/s41408-021-00459-7',
    'https://jeccr.biomedcentral.com/articles/10.1186/s13046-022-02327-z',
    'https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1000387',
    'https://rosap.ntl.bts.gov/view/dot/37370',
    'https://rosap.ntl.bts.gov/view/dot/37370',
    'https://www.nature.com/articles/s41434-021-00246-w',
    'https://www.cell.com/molecular-therapy-family/oncolytics/fulltext/S2372-7705(16)30038-9'
  ];

  List<dynamic> results = responseData['searchResults']['results'];

  for (final (index, item) in results.indexed) {
    String pdfUrl = pdfPool[Random().nextInt(pdfPool.length)];
    String htmlUrl = htmlPool[Random().nextInt(htmlPool.length)];

    responseData['searchResults']['results'][index]['downloadLink'] = pdfUrl;
    if (pdfUrl == '') {
      responseData['searchResults']['results'][index]['zendyLink'] = htmlUrl;
    }
  }

  return responseData;
}

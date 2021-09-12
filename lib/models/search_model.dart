// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.data,
    this.searchCounter,
  });

  Data data;
  int searchCounter;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        data: Data.fromJson(json["data"]),
        searchCounter: json["searchCounter"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "searchCounter": searchCounter,
      };
}

class Data {
  Data({
    this.searchRequestCriteria,
    this.searchResults,
  });

  SearchRequestCriteria searchRequestCriteria;
  SearchResults searchResults;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        searchRequestCriteria:
            SearchRequestCriteria.fromJson(json["searchRequestCriteria"]),
        searchResults: SearchResults.fromJson(json["searchResults"]),
      );

  Map<String, dynamic> toJson() => {
        "searchRequestCriteria": searchRequestCriteria.toJson(),
        "searchResults": searchResults.toJson(),
      };
}

class SearchRequestCriteria {
  SearchRequestCriteria({
    this.searchQuery,
    this.appliedFacets,
  });

  List<SearchQuery> searchQuery;
  List<dynamic> appliedFacets;

  factory SearchRequestCriteria.fromJson(Map<String, dynamic> json) =>
      SearchRequestCriteria(
        searchQuery: List<SearchQuery>.from(
            json["searchQuery"].map((x) => SearchQuery.fromJson(x))),
        appliedFacets: List<dynamic>.from(json["appliedFacets"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "searchQuery": List<dynamic>.from(searchQuery.map((x) => x.toJson())),
        "appliedFacets": List<dynamic>.from(appliedFacets.map((x) => x)),
      };
}

class SearchQuery {
  SearchQuery({
    this.term,
  });

  String term;

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
        term: json["term"],
      );

  Map<String, dynamic> toJson() => {
        "term": term,
      };
}

class SearchResults {
  SearchResults({
    this.totalResults,
    this.maximumScore,
    this.results,
    this.availableFacets,
  });

  int totalResults;
  double maximumScore;
  List<SearchModelResultItem> results;
  List<AvailableFacet> availableFacets;

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        totalResults: json["totalResults"],
        maximumScore: json["maximumScore"].toDouble(),
        results: List<SearchModelResultItem>.from(
            json["results"].map((x) => SearchModelResultItem.fromJson(x))),
        availableFacets: List<AvailableFacet>.from(
            json["availableFacets"].map((x) => AvailableFacet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "maximumScore": maximumScore,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "availableFacets":
            List<dynamic>.from(availableFacets.map((x) => x.toJson())),
      };
}

class AvailableFacet {
  AvailableFacet({
    this.categoryId,
    this.categoryLabel,
    this.facets,
  });

  String categoryId;
  String categoryLabel;
  List<Facet> facets;

  factory AvailableFacet.fromJson(Map<String, dynamic> json) => AvailableFacet(
        categoryId: json["categoryId"],
        categoryLabel: json["categoryLabel"],
        facets: List<Facet>.from(json["facets"].map((x) => Facet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryLabel": categoryLabel,
        "facets": List<dynamic>.from(facets.map((x) => x.toJson())),
      };
}

class Facet {
  Facet({
    this.facetLabel,
    this.count,
    this.active,
  });

  String facetLabel;
  int count;
  bool active;

  factory Facet.fromJson(Map<String, dynamic> json) => Facet(
        facetLabel: json["facetLabel"],
        count: json["count"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "facetLabel": facetLabel,
        "count": count,
        "active": active,
      };
}

class SearchModelResultItem {
  SearchModelResultItem({
    this.resultId,
    this.header,
    this.title,
    this.resultAbstract,
    this.publicationName,
    this.publicationYear,
    this.publicationType,
    this.publicationDate,
    this.language,
    this.authors,
    this.keywords,
    this.subjects,
    this.isOpenAccess,
    this.licenseType,
    this.snip,
    this.snipYear,
    this.hIndex,
    this.doi,
    this.pIssn,
    this.eIssn,
    this.issn,
    this.isbn,
    this.issue,
    this.volume,
    this.journalTitle,
    this.zendyLink,
    this.downloadLink,
    this.permanentLinkId,
    this.resultScore,
  });

  int resultId;
  Header header;
  String title;
  String resultAbstract;
  String publicationName;
  dynamic publicationYear;
  String publicationType;
  String publicationDate;
  String language;
  String authors;
  String keywords;
  String subjects;
  bool isOpenAccess;
  String licenseType;
  String snip;
  String snipYear;
  String hIndex;
  String doi;
  String pIssn;
  String eIssn;
  String issn;
  String isbn;
  String issue;
  String volume;
  String journalTitle;
  String zendyLink;
  String downloadLink;
  String permanentLinkId;
  double resultScore;

  factory SearchModelResultItem.fromJson(Map<String, dynamic> json) =>
      SearchModelResultItem(
        resultId: json["resultId"],
        header: Header.fromJson(json["header"]),
        title: json["title"],
        resultAbstract: json["abstract"],
        publicationName:
            json["publicationName"] == null ? null : json["publicationName"],
        publicationYear: json["publicationYear"],
        publicationType: json["publicationType"],
        publicationDate: json["publicationDate"],
        language: json["language"],
        authors: json["authors"],
        keywords: json["keywords"],
        // subjects: json["subjects"] == null ? null : json["subjects"],
        isOpenAccess: json["isOpenAccess"],
        licenseType: json["licenseType"],
        snip: json["snip"],
        snipYear: json["snipYear"],
        hIndex: json["hIndex"],
        doi: json["doi"],
        pIssn: json["pISSN"],
        eIssn: json["eISSN"],
        issn: json["issn"],
        isbn: json["isbn"],
        issue: json["issue"],
        volume: json["volume"],
        journalTitle: json["journalTitle"],
        zendyLink: json["zendyLink"],
        downloadLink: json["downloadLink"],
        permanentLinkId: json["permanentLinkId"],
        resultScore: json["resultScore"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "resultId": resultId,
        "header": header.toJson(),
        "title": title,
        "abstract": resultAbstract,
        "publicationName": publicationName == null ? null : publicationName,
        "publicationYear": publicationYear,
        "publicationType": publicationType,
        "publicationDate": publicationDate,
        "language": language,
        "authors": authors,
        "keywords": keywords,
        "subjects": subjects == null ? null : subjects,
        "isOpenAccess": isOpenAccess,
        "licenseType": licenseType,
        "snip": snip,
        "snipYear": snipYear,
        "hIndex": hIndex,
        "doi": doi,
        "pISSN": pIssn,
        "eISSN": eIssn,
        "issn": issn,
        "isbn": isbn,
        "issue": issue,
        "volume": volume,
        "journalTitle": journalTitle,
        "zendyLink": zendyLink,
        "downloadLink": downloadLink,
        "permanentLinkId": permanentLinkId,
        "resultScore": resultScore,
      };
}

class Header {
  Header();

  factory Header.fromJson(Map<String, dynamic> json) => Header();

  Map<String, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

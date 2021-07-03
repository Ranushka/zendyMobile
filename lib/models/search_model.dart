// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.total,
    this.page,
    this.pageSize,
    this.timestamp,
    this.query,
    this.results,
    this.next,
    this.last,
  });

  int total;
  int page;
  int pageSize;
  DateTime timestamp;
  String query;
  List<SearchModelResult> results;
  String next;
  String last;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        total: json["total"],
        page: json["page"],
        pageSize: json["pageSize"],
        timestamp: DateTime.parse(json["timestamp"]),
        query: json["query"],
        results: List<SearchModelResult>.from(
            json["results"].map((x) => SearchModelResult.fromJson(x))),
        next: json["next"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pageSize": pageSize,
        "timestamp": timestamp.toIso8601String(),
        "query": query,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "next": next,
        "last": last,
      };
}

class SearchModelResult {
  SearchModelResult({
    this.lastUpdated,
    this.bibjson,
    this.admin,
    this.createdDate,
    this.id,
  });

  DateTime lastUpdated;
  SearchModelResultItem bibjson;
  Admin admin;
  DateTime createdDate;
  String id;

  factory SearchModelResult.fromJson(Map<String, dynamic> json) =>
      SearchModelResult(
        lastUpdated: DateTime.parse(json["last_updated"]),
        bibjson: SearchModelResultItem.fromJson(json["bibjson"]),
        admin: json["admin"] == null ? null : Admin.fromJson(json["admin"]),
        createdDate: DateTime.parse(json["created_date"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "last_updated": lastUpdated.toIso8601String(),
        "bibjson": bibjson.toJson(),
        "admin": admin == null ? null : admin.toJson(),
        "created_date": createdDate.toIso8601String(),
        "id": id,
      };
}

class Admin {
  Admin({
    this.seal,
  });

  bool seal;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        seal: json["seal"],
      );

  Map<String, dynamic> toJson() => {
        "seal": seal,
      };
}

class SearchModelResultItem {
  SearchModelResultItem({
    this.identifier,
    this.journal,
    this.month,
    this.keywords,
    this.year,
    this.startPage,
    this.subject,
    this.author,
    this.link,
    this.bibjsonAbstract,
    this.title,
    this.endPage,
  });

  List<Identifier> identifier;
  Journal journal;
  String month;
  List<String> keywords;
  String year;
  String startPage;
  List<Subject> subject;
  List<Author> author;
  List<Link> link;
  String bibjsonAbstract;
  String title;
  String endPage;

  factory SearchModelResultItem.fromJson(Map<String, dynamic> json) =>
      SearchModelResultItem(
        identifier: List<Identifier>.from(
            json["identifier"].map((x) => Identifier.fromJson(x))),
        journal: Journal.fromJson(json["journal"]),
        month: json["month"] == null ? null : json["month"],
        keywords: json["keywords"] == null
            ? null
            : List<String>.from(json["keywords"].map((x) => x)),
        year: json["year"],
        startPage: json["start_page"] == null ? null : json["start_page"],
        subject:
            List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        link: List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        bibjsonAbstract: json["abstract"],
        title: json["title"],
        endPage: json["end_page"] == null ? null : json["end_page"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": List<dynamic>.from(identifier.map((x) => x.toJson())),
        "journal": journal.toJson(),
        "month": month == null ? null : month,
        "keywords": keywords == null
            ? null
            : List<dynamic>.from(keywords.map((x) => x)),
        "year": year,
        "start_page": startPage == null ? null : startPage,
        "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "link": List<dynamic>.from(link.map((x) => x.toJson())),
        "abstract": bibjsonAbstract,
        "title": title,
        "end_page": endPage == null ? null : endPage,
      };
}

class Author {
  Author({
    this.affiliation,
    this.name,
    this.orcidId,
  });

  String affiliation;
  String name;
  String orcidId;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        affiliation: json["affiliation"],
        name: json["name"],
        orcidId: json["orcid_id"] == null ? null : json["orcid_id"],
      );

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation,
        "name": name,
        "orcid_id": orcidId == null ? null : orcidId,
      };
}

class Identifier {
  Identifier({
    this.id,
    this.type,
  });

  String id;
  IdentifierType type;

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        id: json["id"],
        type: identifierTypeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": identifierTypeValues.reverse[type],
      };
}

enum IdentifierType { DOI, EISSN, PISSN, TYPE_DOI }

final identifierTypeValues = EnumValues({
  "doi": IdentifierType.DOI,
  "eissn": IdentifierType.EISSN,
  "pissn": IdentifierType.PISSN,
  "DOI": IdentifierType.TYPE_DOI
});

class Journal {
  Journal({
    this.volume,
    this.country,
    this.license,
    this.issns,
    this.publisher,
    this.language,
    this.title,
    this.number,
  });

  String volume;
  String country;
  List<License> license;
  List<String> issns;
  String publisher;
  List<Language> language;
  String title;
  String number;

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        volume: json["volume"],
        country: json["country"],
        license: json["license"] == null
            ? null
            : List<License>.from(
                json["license"].map((x) => License.fromJson(x))),
        issns: List<String>.from(json["issns"].map((x) => x)),
        publisher: json["publisher"],
        language: List<Language>.from(
            json["language"].map((x) => languageValues.map[x])),
        title: json["title"],
        number: json["number"] == null ? null : json["number"],
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "country": country,
        "license": license == null
            ? null
            : List<dynamic>.from(license.map((x) => x.toJson())),
        "issns": List<dynamic>.from(issns.map((x) => x)),
        "publisher": publisher,
        "language":
            List<dynamic>.from(language.map((x) => languageValues.reverse[x])),
        "title": title,
        "number": number == null ? null : number,
      };
}

enum Language { EN, FR, ZH }

final languageValues =
    EnumValues({"EN": Language.EN, "FR": Language.FR, "ZH": Language.ZH});

class License {
  License({
    this.openAccess,
    this.title,
    this.type,
    this.url,
  });

  bool openAccess;
  String title;
  String type;
  String url;

  factory License.fromJson(Map<String, dynamic> json) => License(
        openAccess: json["open_access"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "open_access": openAccess,
        "title": title,
        "type": type,
        "url": url,
      };
}

class Link {
  Link({
    this.contentType,
    this.type,
    this.url,
  });

  String contentType;
  LinkType type;
  String url;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        contentType: json["content_type"] == null ? null : json["content_type"],
        type: linkTypeValues.map[json["type"]],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "content_type": contentType == null ? null : contentType,
        "type": linkTypeValues.reverse[type],
        "url": url,
      };
}

enum LinkType { FULLTEXT }

final linkTypeValues = EnumValues({"fulltext": LinkType.FULLTEXT});

class Subject {
  Subject({
    this.code,
    this.scheme,
    this.term,
  });

  String code;
  Scheme scheme;
  String term;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        code: json["code"],
        scheme: schemeValues.map[json["scheme"]],
        term: json["term"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "scheme": schemeValues.reverse[scheme],
        "term": term,
      };
}

enum Scheme { LCC }

final schemeValues = EnumValues({"LCC": Scheme.LCC});

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

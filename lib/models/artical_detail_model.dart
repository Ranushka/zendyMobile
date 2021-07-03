// To parse this JSON data, do
//
//     final articalDetail = articalDetailFromJson(jsonString);

import 'dart:convert';

ArticleDetailModel articalDetailFromJson(String str) =>
    ArticleDetailModel.fromJson(json.decode(str));

String articalDetailToJson(ArticleDetailModel data) =>
    json.encode(data.toJson());

class ArticleDetailModel {
  ArticleDetailModel({
    this.admin,
    this.bibjson,
    this.createdDate,
    this.esType,
    this.id,
    this.lastUpdated,
  });

  Admin admin;
  Bibjson bibjson;
  DateTime createdDate;
  String esType;
  String id;
  DateTime lastUpdated;

  factory ArticleDetailModel.fromJson(Map<String, dynamic> json) =>
      ArticleDetailModel(
        admin: Admin.fromJson(json["admin"]),
        bibjson: Bibjson.fromJson(json["bibjson"]),
        createdDate: DateTime.parse(json["created_date"]),
        esType: json["es_type"],
        id: json["id"],
        lastUpdated: DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "admin": admin.toJson(),
        "bibjson": bibjson.toJson(),
        "created_date": createdDate.toIso8601String(),
        "es_type": esType,
        "id": id,
        "last_updated": lastUpdated.toIso8601String(),
      };
}

class Admin {
  Admin({
    this.inDoaj,
    this.publisherRecordId,
    this.seal,
    this.uploadId,
  });

  bool inDoaj;
  String publisherRecordId;
  bool seal;
  String uploadId;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        inDoaj: json["in_doaj"],
        publisherRecordId: json["publisher_record_id"],
        seal: json["seal"],
        uploadId: json["upload_id"],
      );

  Map<String, dynamic> toJson() => {
        "in_doaj": inDoaj,
        "publisher_record_id": publisherRecordId,
        "seal": seal,
        "upload_id": uploadId,
      };
}

class Bibjson {
  Bibjson({
    this.bibjsonAbstract,
    this.author,
    this.identifier,
    this.journal,
    this.keywords,
    this.link,
    this.month,
    this.subject,
    this.title,
    this.year,
  });

  String bibjsonAbstract;
  List<Author> author;
  List<Identifier> identifier;
  Journal journal;
  List<String> keywords;
  List<Link> link;
  String month;
  List<Subject> subject;
  String title;
  String year;

  factory Bibjson.fromJson(Map<String, dynamic> json) => Bibjson(
        bibjsonAbstract: json["abstract"],
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        identifier: List<Identifier>.from(
            json["identifier"].map((x) => Identifier.fromJson(x))),
        journal: Journal.fromJson(json["journal"]),
        keywords: List<String>.from(json["keywords"]?.map((x) => x)),
        link: List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        month: json["month"],
        subject:
            List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
        title: json["title"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "abstract": bibjsonAbstract,
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "identifier": List<dynamic>.from(identifier.map((x) => x.toJson())),
        "journal": journal.toJson(),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "link": List<dynamic>.from(link.map((x) => x.toJson())),
        "month": month,
        "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
        "title": title,
        "year": year,
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
        orcidId: json["orcid_id"],
      );

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation,
        "name": name,
        "orcid_id": orcidId,
      };
}

class Identifier {
  Identifier({
    this.id,
    this.type,
  });

  String id;
  String type;

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class Journal {
  Journal({
    this.country,
    this.endPage,
    this.language,
    this.number,
    this.publisher,
    this.startPage,
    this.title,
    this.volume,
  });

  String country;
  String endPage;
  List<String> language;
  String number;
  String publisher;
  String startPage;
  String title;
  String volume;

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
        country: json["country"],
        endPage: json["end_page"],
        language: List<String>.from(json["language"].map((x) => x)),
        number: json["number"],
        publisher: json["publisher"],
        startPage: json["start_page"],
        title: json["title"],
        volume: json["volume"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "end_page": endPage,
        "language": List<dynamic>.from(language.map((x) => x)),
        "number": number,
        "publisher": publisher,
        "start_page": startPage,
        "title": title,
        "volume": volume,
      };
}

class Link {
  Link({
    this.contentType,
    this.type,
    this.url,
  });

  String contentType;
  String type;
  String url;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        contentType: json["content_type"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "content_type": contentType,
        "type": type,
        "url": url,
      };
}

class Subject {
  Subject({
    this.code,
    this.scheme,
    this.term,
  });

  String code;
  String scheme;
  String term;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        code: json["code"],
        scheme: json["scheme"],
        term: json["term"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "scheme": scheme,
        "term": term,
      };
}

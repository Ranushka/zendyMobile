class FeaturedContentModel {
  int id;
  String title;
  String paragraph;
  String image;
  String url;
  String search;
  String startDateTime;
  String endDateTime;
  bool vertical;
  String order;

  FeaturedContentModel(
      {this.id,
      this.title,
      this.paragraph,
      this.image,
      this.url,
      this.search,
      this.startDateTime,
      this.endDateTime,
      this.vertical,
      this.order});

  FeaturedContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    paragraph = json['paragraph'];
    image = json['image'];
    url = json['url'];
    search = json['search'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    vertical = json['vertical'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['paragraph'] = this.paragraph;
    data['image'] = this.image;
    data['url'] = this.url;
    data['search'] = this.search;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['vertical'] = this.vertical;
    data['order'] = this.order;
    return data;
  }
}

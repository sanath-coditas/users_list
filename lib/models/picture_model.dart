class Picture {
 String? large = "";
 String? medium = "";
 String? thumbnail = "";

  Picture({required this.large, required this.medium, required this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large']??"";
    medium = json['medium']??"";
    thumbnail = json['thumbnail']??"";
  }
  String? get getMedium{
    if(medium != null) {
      return medium;
    } else {
      return "";
    }
  }
  String? get getThumbnail{
    return thumbnail;
  }
  String? get getLarge{
    return large;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['large'] = large;
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
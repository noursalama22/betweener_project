import 'package:betweener_project/models/user.dart';

class Follow{
  int? following_count; 
  int? followers_count ;
  List<UserClass>? following;
  List<UserClass>? followers;
  Follow({
    this.following_count,
    this.followers_count,
    this.following,
    this.followers
  });

   factory Follow.fromJson(Map<String, dynamic> json) => Follow(
       following_count:  json["following_count"],
       followers_count: json['followers_count'],
        following: json["following"] == null
            ? []
            : List<UserClass>.from(json['following'].map((x) => UserClass.fromJson(x))),
     
      followers: json["following"] == null
            ? []
            : List<UserClass>.from(json['followers'].map((x) => UserClass.fromJson(x))),
     );
//
}


// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    List<DataListUser> data;
    int total;
    int page;
    int limit;

    UserModel({
        required this.data,
        required this.total,
        required this.page,
        required this.limit,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: List<DataListUser>.from(json["data"].map((x) => DataListUser.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
    };
}

class DataListUser {
    String id;
    Title title;
    String firstName;
    String lastName;
    String picture;

    DataListUser({
        required this.id,
        required this.title,
        required this.firstName,
        required this.lastName,
        required this.picture,
    });

    factory DataListUser.fromJson(Map<String, dynamic> json) => DataListUser(
        id: json["id"],
        title: titleValues.map[json["title"]]!,
        firstName: json["firstName"],
        lastName: json["lastName"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "firstName": firstName,
        "lastName": lastName,
        "picture": picture,
    };
}

enum Title { MR, MS, MISS, MRS }

final titleValues = EnumValues({
    "miss": Title.MISS,
    "mr": Title.MR,
    "mrs": Title.MRS,
    "ms": Title.MS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

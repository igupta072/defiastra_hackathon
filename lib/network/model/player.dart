/// id : ""
/// isActive : true
/// hasLeft : true
/// avatar : ""
/// username : ""

class Player {
  Player({
    this.id,
    this.isActive,
    this.hasLeft,
    this.avatar,
    this.username,
  });

  Player.fromJson(dynamic json) {
    id = json['id'];
    isActive = json['isActive'];
    hasLeft = json['hasLeft'];
    avatar = json['avatar'];
    username = json['username'];
  }

  String? id;
  bool? isActive;
  bool? hasLeft;
  String? avatar;
  String? username;

  Player copyWith({
    String? id,
    bool? isActive,
    bool? hasLeft,
    String? avatar,
    String? username,
  }) =>
      Player(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        hasLeft: hasLeft ?? this.hasLeft,
        avatar: avatar ?? this.avatar,
        username: username ?? this.username,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['isActive'] = isActive;
    map['hasLeft'] = hasLeft;
    map['avatar'] = avatar;
    map['username'] = username;
    return map;
  }
}

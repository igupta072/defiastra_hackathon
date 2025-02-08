/// image : ""
/// game_type : ""
/// game_id : ""
/// name : ""

class GameModel {
  GameModel({
    this.image,
    this.gameType,
    this.gameId,
    this.name,
  });

  GameModel.fromJson(dynamic json) {
    image = json['image'];
    gameType = json['game_type'];
    gameId = json['game_id'];
    name = json['name'];
  }

  String? image;
  String? gameType;
  String? gameId;
  String? name;

  GameModel copyWith({
    String? image,
    String? gameType,
    String? gameId,
    String? name,
  }) =>
      GameModel(
        image: image ?? this.image,
        gameType: gameType ?? this.gameType,
        gameId: gameId ?? this.gameId,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['game_type'] = gameType;
    map['game_id'] = gameId;
    map['name'] = name;
    return map;
  }
}

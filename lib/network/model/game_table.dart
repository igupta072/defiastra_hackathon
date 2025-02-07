import 'package:defiastra_hackathon/network/model/player.dart';

/// id : ""
/// seats : []
/// rounds : [{"rn":1,"won":{}}]
/// status : ""
/// table_amount : ""
/// created_at : ""

class GameTable {
  GameTable({
    this.id,
    this.seats,
    this.rounds,
    this.status,
    this.tableAmount,
    this.createdAt,
  });

  GameTable.fromJson(dynamic json) {
    id = json['id'];
    if (json['seats'] != null) {
      seats = [];
      json['seats'].forEach((v) {
        seats?.add(Player.fromJson(v));
      });
    }
    if (json['rounds'] != null) {
      rounds = [];
      json['rounds'].forEach((v) {
        rounds?.add(Rounds.fromJson(v));
      });
    }
    status = json['status'];
    tableAmount = json['table_amount'];
    createdAt = json['created_at'];
  }

  String? id;
  List<Player>? seats;
  List<Rounds>? rounds;
  String? status;
  String? tableAmount;
  String? createdAt;

  GameTable copyWith({
    String? id,
    List<Player>? seats,
    List<Rounds>? rounds,
    String? status,
    String? tableAmount,
    String? createdAt,
  }) =>
      GameTable(
        id: id ?? this.id,
        seats: seats ?? this.seats,
        rounds: rounds ?? this.rounds,
        status: status ?? this.status,
        tableAmount: tableAmount ?? this.tableAmount,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (seats != null) {
      map['seats'] = seats?.map((v) => v.toJson()).toList();
    }
    if (rounds != null) {
      map['rounds'] = rounds?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['table_amount'] = tableAmount;
    map['created_at'] = createdAt;
    return map;
  }
}

/// rn : 1
/// won : {}

class Rounds {
  Rounds({
    this.rn,
    this.won,
  });

  Rounds.fromJson(dynamic json) {
    rn = json['rn'];
    won = json['won'];
  }

  num? rn;
  Player? won;

  Rounds copyWith({
    num? rn,
    Player? won,
  }) =>
      Rounds(
        rn: rn ?? this.rn,
        won: won ?? this.won,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rn'] = rn;
    map['won'] = won?.toJson();
    return map;
  }
}

class Pokemon {
  final List<AbilityElement> abilities;
  final List<Move> moves;
  final String name;
  final Sprites sprites;

  Pokemon({
    required this.abilities,
    required this.moves,
    required this.name,
    required this.sprites,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    abilities: List<AbilityElement>.from(
      json["abilities"].map((x) => AbilityElement.fromJson(x)),
    ),
    moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
    name: json["name"],
    sprites: Sprites.fromJson(json["sprites"]),
  );

  Map<String, dynamic> toJson() => {
    "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
    "name": name,
    "sprites": sprites.toJson(),
  };
}

class AbilityElement {
  final MoveClass ability;

  AbilityElement({required this.ability});

  factory AbilityElement.fromJson(Map<String, dynamic> json) =>
      AbilityElement(ability: MoveClass.fromJson(json["ability"]));

  Map<String, dynamic> toJson() => {"ability": ability.toJson()};
}

class MoveClass {
  final String name;

  MoveClass({required this.name});

  factory MoveClass.fromJson(Map<String, dynamic> json) =>
      MoveClass(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}

class Move {
  final MoveClass move;

  Move({required this.move});

  factory Move.fromJson(Map<String, dynamic> json) =>
      Move(move: MoveClass.fromJson(json["move"]));

  Map<String, dynamic> toJson() => {"move": move.toJson()};
}

class Sprites {
  final Other other;

  Sprites({required this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      Sprites(other: Other.fromJson(json["other"]));

  Map<String, dynamic> toJson() => {"other": other.toJson()};
}

class Other {
  final OfficialArtwork officialArtwork;

  Other({required this.officialArtwork});

  factory Other.fromJson(Map<String, dynamic> json) => Other(
    officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
  );

  Map<String, dynamic> toJson() => {
    "official-artwork": officialArtwork.toJson(),
  };
}

class OfficialArtwork {
  final String frontDefault;

  OfficialArtwork({required this.frontDefault});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      OfficialArtwork(frontDefault: json["front_default"]);

  Map<String, dynamic> toJson() => {"front_default": frontDefault};
}

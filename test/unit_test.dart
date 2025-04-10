import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/features/search/models/pokemon.dart';

void main() {
  test('Pokemon model parses JSON correctly', () {
    final json = {
      "abilities": [
        {
          "ability": {
            "name": "lightning-rod"
          }
        }
      ],
      "moves": [
        {
          "move": {
            "name": "upper-hand"
          }
        }
      ],
      "name": "pikachu",
      "sprites": {
        "other": {
          "official-artwork": {
            "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
          }
        }
      }
    };

    final pokemon = Pokemon.fromJson(json);
    expect(pokemon.name, 'pikachu');
    expect(pokemon.abilities.first.ability.name, 'lightning-rod');
    expect(pokemon.moves.first.move.name, 'upper-hand');
  });

}

import 'package:flutter/material.dart';
import 'package:pokedex/features/search/models/pokemon.dart';

class CardItemView extends StatelessWidget {
  const CardItemView({required this.pokemon, super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                pokemon.sprites.other.officialArtwork.frontDefault,
                fit: BoxFit.fill,
                scale: 5,
                filterQuality: FilterQuality.high,
              ),
            ),
            Spacer(),

            Row(
              children: [
                Text(
                  pokemon.name.toString().toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),

            const Divider(),
            Spacer(),
            RichText(
              text: TextSpan(
                text: 'Abilities:',
                // base text
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
                // base style
                children: [
                  TextSpan(
                    text:
                        ' ${pokemon.abilities.map((e) => '#${e.ability.name}').toList().join(', ')}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: 'Moves:',
                // base text
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
                // base style
                children: [
                  TextSpan(
                    text:
                        ' ${pokemon.moves.take(3).map((e) => '#${e.move.name}').toList().join(', ')}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

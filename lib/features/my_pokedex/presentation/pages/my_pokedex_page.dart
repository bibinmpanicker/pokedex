import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/providers/repository_providers.dart';
import 'package:pokedex/core/utils/utils.dart';
import 'package:pokedex/features/my_pokedex/states/my_pokedex_provider.dart';
import 'package:pokedex/features/search/models/pokemon.dart';

class MyPokedexPage extends ConsumerStatefulWidget {
  const MyPokedexPage({super.key});

  static const route = '/my_pokedex';

  @override
  _MyPokedexPageState createState() => _MyPokedexPageState();
}

class _MyPokedexPageState extends ConsumerState<MyPokedexPage> {
  final _scrollController = ScrollController();

  Widget _buildBody(List<Pokemon> state) {
    final generatedChildren = List.generate(
      state.length,
      (index) => _Item(state[index]),
    );
    return ReorderableBuilder(
      children: generatedChildren,
      positionDuration: Duration.zero,
      releasedChildDuration: Duration.zero,
      scrollController: _scrollController,
      onReorder: (ReorderedListFunction reorderedListFunction) {
        final List<Pokemon> newList =
            reorderedListFunction(state) as List<Pokemon>;
        ref.read(myPokedexProvider.notifier).reorderPokemon(newList);
      },
      builder: (children) {
        return GridView(
          children: children,
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1 / 1.5,
          ),
        );
      },
    );
  }

  Widget _Item(Pokemon pokemon) {
    return Stack(
      key: ValueKey(pokemon.name),
      children: [
        Card(
          margin: const EdgeInsets.all(8),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
        ),
        Positioned(
          top: 8,
          right: 4,
          child: IconButton(
            onPressed: () async {
              final confirmed = await showConfirmDeleteDialog(
                context: context,
                title: 'Delete Pokémon',
                subtitle:
                    'Are you sure you want to delete "${pokemon.name.toUpperCase()}" from your Pokédex?',
                actionButtonName: 'Delete',
              );
              if (confirmed) {
                ref
                    .read(storageRepositoryProvider)
                    .deleteFromPokedex(pokemon.name);
                ref.invalidate(myPokedexProvider);
              }
            },
            icon: Icon(Icons.delete_outline_sharp),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myPokedexProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("My Pokédex")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            state.when(
              data: (data) => Expanded(child: _buildBody(data)),
              error: (_, __) => Center(child: Text('Error')),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

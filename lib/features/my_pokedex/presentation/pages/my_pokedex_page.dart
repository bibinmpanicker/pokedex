import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/providers/repository_providers.dart';
import 'package:pokedex/core/utils/utils.dart';
import 'package:pokedex/features/my_pokedex/presentation/wdgets/card_item_view.dart';
import 'package:pokedex/features/my_pokedex/states/my_pokedex_provider.dart';
import 'package:pokedex/features/search/models/pokemon.dart';

class MyPokedexPage extends ConsumerStatefulWidget {
  const MyPokedexPage({super.key});

  static const route = '/my_pokedex';

  @override
  MyPokedexPageState createState() => MyPokedexPageState();
}

class MyPokedexPageState extends ConsumerState<MyPokedexPage> {
  final _scrollController = ScrollController();

  Widget _buildBody(List<Pokemon> pokemon) {
    final generatedChildren = List.generate(
      pokemon.length,
      (index) => _itemView(pokemon[index]),
    );
    return pokemon.isEmpty
        ? Center(
          child: Text(
            'No saved Pokemon!!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
        : ReorderableBuilder(
          positionDuration: Duration.zero,
          releasedChildDuration: Duration.zero,
          scrollController: _scrollController,
          onReorder: (ReorderedListFunction reorderedListFunction) {
            final List<Pokemon> newList =
                reorderedListFunction(pokemon) as List<Pokemon>;
            ref.read(myPokedexProvider.notifier).reorderPokemon(newList);
          },
          builder: (children) {
            return GridView(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              children: children,
            );
          },
          children: generatedChildren,
        );
  }

  Widget _itemView(Pokemon pokemon) {
    return Stack(
      key: ValueKey(pokemon.name),
      children: [
        CardItemView(pokemon: pokemon),
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

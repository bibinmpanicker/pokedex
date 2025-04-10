import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/prefs/prefs_connector.dart';
import 'package:pokedex/features/login/presentation/pages/login_page.dart';
import 'package:pokedex/features/my_pokedex/presentation/pages/my_pokedex_page.dart';
import 'package:pokedex/features/my_pokedex/presentation/wdgets/card_item_view.dart';
import 'package:pokedex/features/search/states/search_notifier.dart';

import '../../../core/utils/utils.dart';
import '../models/pokemon.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  static const route = '/home';

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _searchPokemon() async {
    FocusScope.of(context).unfocus();
    ref
        .read(searchProvider.notifier)
        .search(_searchController.text.trim().toLowerCase());
  }

  void _surpriseMe() async {
    FocusScope.of(context).unfocus();

    ref.read(searchProvider.notifier).surpriseMe();
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: false,
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Enter Pokémon name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: _searchPokemon, child: const Text("Search")),
      ],
    );
  }

  Widget _buildBody(List<Pokemon> pokemon) {
    return GridView.builder(
      itemCount: pokemon.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            CardItemView(pokemon: pokemon[index]),
            Positioned(
              top: 8,
              right: 4,
              child: IconButton(
                onPressed: () async {
                  await ref
                      .read(searchProvider.notifier)
                      .addToPokedex(pokemon[index]);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved successfully!')),
                    );
                  }
                },
                icon: Icon(Icons.bookmark_add_outlined),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Surprise Me!'),
        onPressed: _surpriseMe,
      ),
      appBar: AppBar(
        title: const Text(
          "Pokédex",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.catching_pokemon_rounded, color: Colors.red[700]),
            onPressed: () => context.push(MyPokedexPage.route),
          ),
          IconButton(
            icon: Icon(Icons.power_settings_new_rounded, color: Colors.black),
            onPressed: () async {
              final bool isConfirmed = await showConfirmDeleteDialog(
                context: context,
                title: 'Logout',
                subtitle: 'Are you sure you want to logout?',
                actionButtonName: 'Logout',
              );

              if (isConfirmed) {
                Prefs.clear();
                if (context.mounted) {
                  context.go(LoginPage.route);
                  FocusScope.of(context).unfocus();
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchSection(),

            if (state.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (state.hasError)
              const _ErrorView()
            else if (state.pokemon.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Search your Pokemon!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              )
            else ...[
              const SizedBox(height: 12),
              Expanded(child: _buildBody(state.pokemon)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Card(
          color: Color(0xFFFFE0E0),
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Pokémon not found. Try another name.",
              style: TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/providers/repository_providers.dart';
import 'package:pokedex/features/search/models/pokemon.dart';
import 'package:pokedex/features/search/models/pokemon_list.dart';
import 'package:pokedex/features/search/states/search_state.dart';

class SearchNotifier extends AutoDisposeNotifier<SearchState> {
  @override
  SearchState build() => SearchState.initial();

  /// This function checks whether there is cached data. If not it will fetch from api/
  Future<void> surpriseMe() async {
    state = state.copyWith(isLoading: true, hasError: false);

    try {
      final List<Pokemon> cachedPokemons =
          await ref.read(storageRepositoryProvider).loadCachedPokemons();
      if (cachedPokemons.isNotEmpty && cachedPokemons.length >= 10) {
        state = state.copyWith(pokemon: cachedPokemons, isLoading: false);
      } else {
        // pulls 10 random Pokemons from api.
        Random random = Random();
        int offset = random.nextInt(100);
        final PokemonList resModel = await ref
            .read(authRepositoryProvider)
            .getPokemonList(offset);

        // calls details api for each pokemon.
        final futures =
            resModel.results.map((e) async {
              return await ref.read(authRepositoryProvider).search(e.name);
            }).toList();

        final s = await Future.wait(futures);
        state = state.copyWith(pokemon: s, isLoading: false);

        // caches the data.
        ref.read(storageRepositoryProvider).cacheSurpriseMePokemons(s);
      }
    } catch (e) {
      state = state.copyWith(hasError: true, isLoading: false);
    }
  }

  Future<void> search(String name) async {
    state = state.copyWith(isLoading: true, hasError: false);

    try {
      final List<Pokemon> cachedPokemons =
          await ref.read(storageRepositoryProvider).loadCachedPokemons();

      //check whether the Pokemon is in the cached data. If not it will search via api.
      final Pokemon? x = cachedPokemons.firstWhereOrNull(
        (e) => e.name.trim().toLowerCase() == name.trim().toLowerCase(),
      );

      if (x != null) {
        state = state.copyWith(pokemon: [x], isLoading: false);
      } else {
        final Pokemon resModel = await ref
            .read(authRepositoryProvider)
            .search(name);

        state = state.copyWith(pokemon: [resModel], isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(hasError: true, isLoading: false);
    }
  }

  Future<void> addToPokedex(Pokemon pokemon) async {
    await ref.read(storageRepositoryProvider).addToPokedex(pokemon);
  }
}

final searchProvider =
    NotifierProvider.autoDispose<SearchNotifier, SearchState>(() {
      return SearchNotifier();
    });

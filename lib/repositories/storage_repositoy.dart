import 'dart:convert';

import 'package:pokedex/features/search/models/pokemon.dart';
import 'package:pokedex/services/storage_services.dart';

class StorageRepository {
  StorageRepository(this.services);

  final StorageServices services;

  Future<void> addToPokedex(Pokemon pokemon) async {
    final savedPokemons = await loadPokedex();

    // Check if it's already saved
    bool alreadyExists = savedPokemons.any((p) => p.name == pokemon.name);
    if (!alreadyExists) {
      savedPokemons.add(pokemon);
    }

    await services.addToPokedex(
      jsonEncode(savedPokemons.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<Pokemon>> loadPokedex() async {
    final String savedList = await services.loadPokedex();

    if (savedList.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(savedList);
      return decodedList.map((e) => Pokemon.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> deleteFromPokedex(String name) async {
    final savedPokemons = await loadPokedex();
    savedPokemons.removeWhere(
      (e) => e.name.trim().toLowerCase() == name.trim().toLowerCase(),
    );

    await services.addToPokedex(
      jsonEncode(savedPokemons.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> reOrderPokedex(List<Pokemon> updatedList) async {
    clearMyPokedex();

    await services.addToPokedex(
      jsonEncode(updatedList.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> cacheSurpriseMePokemons(List<Pokemon> pokemons) async {
    final savedPokemons = await loadCachedPokemons();

    for (var s in pokemons) {
      // Check if it's already saved
      bool alreadyExists = savedPokemons.any((p) => p.name == s.name);
      if (!alreadyExists) {
        savedPokemons.add(s);
      }
    }

    await services.cachePokemons(
      jsonEncode(savedPokemons.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<Pokemon>> loadCachedPokemons() async {
    final String savedList = await services.loadCachedPokemons();

    if (savedList.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(savedList);
      return decodedList.map((e) => Pokemon.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> clearMyPokedex() => services.clearMyPokedex();
}

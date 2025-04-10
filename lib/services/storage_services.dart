import 'package:dio/dio.dart';
import 'package:pokedex/core/prefs/prefs_constants.dart';

import '../core/prefs/prefs_connector.dart';

class StorageServices {
  StorageServices();

  Future<void> addToPokedex(String pokemon) async {
    await Prefs.setString(PrefsConstants.myPokedex, pokemon);
  }

  Future<String> loadPokedex() async {
    final String? pokemon = await Prefs.getString(PrefsConstants.myPokedex);
    return pokemon ?? '';
  }

  Future<void> clearMyPokedex() async {
    await Prefs.removePreference(PrefsConstants.myPokedex);
  }

  Future<void> cachePokemons(String pokemon) async {
    await Prefs.setString(PrefsConstants.cachedPokemons, pokemon);
  }

  Future<String> loadCachedPokemons() async {
    final String? pokemon = await Prefs.getString(PrefsConstants.cachedPokemons);
    return pokemon ?? '';
  }
}

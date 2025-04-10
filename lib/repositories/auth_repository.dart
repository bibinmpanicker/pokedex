import 'package:pokedex/features/search/models/pokemon.dart';
import 'package:pokedex/services/auth_services.dart';

import '../features/search/models/pokemon_list.dart';

class AuthRepository {
  AuthRepository(this.authServices);

  final AuthServices authServices;

  Future<PokemonList> getPokemonList(int offset) async =>
      PokemonList.fromJson(await authServices.getPokemonList(offset));

  Future<Pokemon> search(String name) async =>
      Pokemon.fromJson(await authServices.search(name));
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/providers/repository_providers.dart';
import 'package:pokedex/features/search/models/pokemon.dart';

class MyPokedexNotifier extends AutoDisposeAsyncNotifier<List<Pokemon>> {
  @override
  Future<List<Pokemon>> build() async {
    return ref.read(storageRepositoryProvider).loadPokedex();
  }

  Future<void> reorderPokemon(List<Pokemon> newList) async {
    await ref.read(storageRepositoryProvider).reOrderPokedex(newList);
    ref.invalidateSelf();
  }
}

final myPokedexProvider =
    AutoDisposeAsyncNotifierProvider<MyPokedexNotifier, List<Pokemon>>(
      () => MyPokedexNotifier(),
    );

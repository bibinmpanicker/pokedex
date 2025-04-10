import 'package:pokedex/features/search/models/pokemon.dart';

class SearchState {
  final List<Pokemon> pokemon;
  final bool isLoading;
  final bool hasError;

  SearchState({
    required this.pokemon,
    required this.isLoading,
    required this.hasError,
  });

  SearchState.initial() : pokemon = [], isLoading = false, hasError = false;

  SearchState copyWith({
    List<Pokemon>? pokemon,
    bool? isLoading,
    bool? hasError,
  }) => SearchState(
    pokemon: pokemon ?? this.pokemon,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
  );
}

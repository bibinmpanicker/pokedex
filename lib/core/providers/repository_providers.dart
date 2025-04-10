import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/providers/service_providers.dart';
import 'package:pokedex/repositories/auth_repository.dart';
import 'package:pokedex/repositories/storage_repositoy.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.watch(authServiceProviders));
});

final storageRepositoryProvider = Provider((ref) {
  return StorageRepository(ref.watch(storageServiceProviders));
});

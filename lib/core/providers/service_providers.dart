import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/dio/providers/dio_provider.dart';
import 'package:pokedex/services/auth_services.dart';
import 'package:pokedex/services/storage_services.dart';

final authServiceProviders = Provider((ref) {
  return AuthServices(ref.watch(dioProvider));
});
final storageServiceProviders = Provider((ref) {
  return StorageServices();
});

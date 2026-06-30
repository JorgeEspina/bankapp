import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard_providers.dart';
import 'dashboard_state.dart';

class DashboardController extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    // Usar Future.microtask para que se ejecute después de la inicialización
    Future.microtask(() => _loadProducts());
    return const DashboardState(isLoading: true);
  }

  Future<void> _loadProducts() async {
    try {
      final getProducts = ref.read(getProductsUseCaseProvider);
      final products = await getProducts();
      state = state.copyWith(
        products: products,
        isLoading: false,
        isFromCache: false,
      );
    } catch (e) {
      // Intentar cache
      final getCached = ref.read(getCachedProductsUseCaseProvider);
      final cached = await getCached();
      if (cached != null && cached.isNotEmpty) {
        state = state.copyWith(
          products: cached,
          isLoading: false,
          isFromCache: true,
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Error al cargar los datos',
        );
      }
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, error: null);
    await _loadProducts();
  }
}

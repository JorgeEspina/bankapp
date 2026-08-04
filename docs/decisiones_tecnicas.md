# Decisiones Técnicas - BankApp

## Arquitectura General

### Modularización por Features
La aplicación sigue una estructura modular basada en features (funcionalidades) alineada con el proyecto `experience_app` para mantener consistencia entre proyectos del equipo.

```
lib/
├── core/                    # Código compartido entre features
│   ├── helpers/             # Formateadores y utilidades de UI
│   ├── network/             # Cliente HTTP (Dio) e interceptores
│   ├── router/              # Configuración de navegación (GoRouter)
│   ├── theme/               # Tema global de la app
│   ├── l10n/                # Internacionalización (i18n)
│   └── utils/               # Utilidades generales (JWT, etc.)
├── features/                # Módulos funcionales independientes
│   ├── accounts/            # Cuentas bancarias
│   ├── authentication/      # Login, registro, sesión
│   ├── configuration/       # Ajustes del usuario
│   ├── dashboard/           # Dashboard de productos y saldos
│   └── home/                # Pantalla principal y navegación
└── main.dart
```

### Patrón por Feature (alineado con experience_app)
Cada feature sigue Clean Architecture con las siguientes capas:

```
feature/
├── data/                    # Capa de datos
│   ├── data_sources/        # Fuentes de datos (remote, local/cache)
│   ├── models/              # Models con fromJson/toJson/toEntity/fromEntity
│   └── repositories/        # Implementación de repositorios (implements domain)
├── domain/                  # Capa de dominio
│   ├── entities/            # Entidades puras del negocio
│   ├── repositories/        # Contratos abstractos de repositorios
│   └── use_cases/           # Casos de uso (clases invocables con call())
└── presentation/            # Capa de presentación
    ├── screens/             # Pantallas (ConsumerWidget / ConsumerStatefulWidget)
    ├── widgets/             # Widgets reutilizables del feature
    └── state/               # Estado y lógica de presentación
        ├── *_providers.dart # Definición de todos los providers (DI)
        ├── *_state.dart     # Clase de estado inmutable con copyWith
        └── *_controller.dart# Notifier<State> con lógica de negocio
```

## Patrón de State Management

### Estructura de 3 archivos (como experience_app)

**`*_providers.dart`** — Define todos los providers en orden de capas:
```dart
// Data Sources
final remoteDataSourceProvider = Provider<RemoteDataSource>(...);

// Repositories
final repositoryProvider = Provider<Repository>(...);

// Use Cases
final useCaseProvider = Provider<UseCase>(...);

// Controller
final controllerProvider = NotifierProvider<Controller, State>(Controller.new);
```

**`*_state.dart`** — Estado inmutable:
```dart
class FeatureState {
  const FeatureState({...});
  final List<Entity> items;
  final bool isLoading;
  final String? error;
  FeatureState copyWith({...});
}
```

**`*_controller.dart`** — Notifier con lógica:
```dart
class FeatureController extends Notifier<FeatureState> {
  @override
  FeatureState build() { ... }
  Future<void> doSomething() { ... }
}
```

### Reglas:
- Usar `Notifier<State>` (no `StateNotifier`) para nuevos features
- Los controllers acceden a use cases via `ref.read(useCaseProvider)`
- Las vistas usan `ref.watch(controllerProvider)` para reactividad
- Las mutaciones se llaman con `ref.read(controllerProvider.notifier).method()`

## Decisiones de Tecnología

| Aspecto | Decisión | Justificación |
|---------|----------|---------------|
| State Management | Flutter Riverpod (Notifier) | Reactividad, testabilidad, patrón del equipo |
| Navegación | GoRouter | Declarativo, deep linking, redirect guards |
| HTTP Client | Dio | Interceptores, mock para desarrollo |
| Serialización | Freezed + json_serializable | Inmutabilidad, code generation |
| Cache Local | SharedPreferences | Ligero, suficiente para cache de saldos |
| Internacionalización | flutter_localizations + ARB | Solución oficial de Flutter |
| Tema | Material 3 | Diseño moderno, soporte dark/light mode |

## HU 3.2 - Dashboard de Productos y Saldos

### Capas implementadas:
- **Domain**: `FinancialProductEntity`, `DashboardRepository` (abstract), `GetProductsUseCase`, `GetCachedProductsUseCase`
- **Data**: `FinancialProductModel` (con toEntity/fromEntity), `DashboardRemoteDataSource`, `DashboardLocalDataSource`, `DashboardRepositoryImpl`
- **Presentation**: `DashboardState`, `DashboardController`, `DashboardProviders`, Screen + Widgets

### Estados manejados:
1. **Loading**: Shimmer/skeleton animado
2. **Error**: Mensaje + botón de reintentar + fallback a cache
3. **Success**: Vista completa de productos y saldos
4. **Cache**: Indicador visual cuando datos vienen de cache local

## HU 3.3 - Internacionalización

### Configuración:
- `l10n.yaml` en raíz del proyecto
- Archivos ARB en `lib/core/l10n/` (app_es.arb, app_en.arb)
- Generación automática con `flutter gen-l10n`
- `flutter: generate: true` en pubspec.yaml

### Selector de idioma:
- `LocaleNotifier` (StateNotifier) persiste selección en SharedPreferences
- Diálogo de selección en pantalla de Configuración
- `MaterialApp.router` usa `locale`, `supportedLocales`, `localizationsDelegates`

### Idiomas soportados:
- Español (es) — por defecto
- Inglés (en)

## Convenciones de Código

- Nombres de archivos: `snake_case`
- Nombres de clases: `PascalCase`
- Providers: sufijo `Provider` (e.g., `dashboardControllerProvider`)
- Controllers: sufijo `Controller` (e.g., `DashboardController`)
- States: sufijo `State` (e.g., `DashboardState`)
- Entities: sufijo `Entity` (e.g., `FinancialProductEntity`)
- Models: sufijo `Model` (e.g., `FinancialProductModel`)
- Use Cases: sufijo `UseCase` (e.g., `GetProductsUseCase`)
- Screens: sufijo `Screen` (e.g., `DashboardScreen`)
- Data sources: sufijo `DataSource` (e.g., `DashboardRemoteDataSource`)
- Carpetas: `data_sources` (no `datasources`), `use_cases` (no `usecases`)

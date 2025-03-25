import 'package:alps2alps_test_task/di.config.dart';
import 'package:alps2alps_test_task/features/main/domain/entities/geo_point.dart';
import 'package:alps2alps_test_task/features/main/presentation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'features/main/presentation/choose_point/choose_point_screen.dart';
import 'features/main/presentation/main/main_screen.dart';
import 'features/main/presentation/widgets/select_number.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.registerSingleton(getIt);

  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  getIt.registerLazySingleton(() {
    return GoRouter(
      navigatorKey: getIt.get<NavigationService>().navigatorKey,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const MainScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'choose_point',
              name: 'choose_point',
              builder: (BuildContext context, GoRouterState state) {
                final latitude = double.tryParse(state.uri.queryParameters['latitude'] ?? '');
                final longitude = double.tryParse(state.uri.queryParameters['longitude'] ?? '');
                final initialPosition = (latitude != null && longitude != null) ? GeoPoint(latitude, longitude) : null;
                return ChoosePointScreen(initialPosition: initialPosition);
              },
            ),
            BottomSheetRoute.material(
              path: 'select_number',
              name: 'select_number',
              screenBuilder: (context, state) => SelectNumberScreen(initialNumber: null),
            ),
          ],
        ),
      ],
    );
  });

  getIt.init();
  await getIt.allReady();
}

class BottomSheetRoute extends GoRoute {
  BottomSheetRoute._({
    required super.path,
    super.name,
    super.parentNavigatorKey,
    super.pageBuilder,
    super.redirect,
  });

  BottomSheetRoute.material({
    String? name,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    required String path,
    required GoRouterWidgetBuilder screenBuilder,
    bool enableDrag = true,
    bool isDismissible = false,
  }) : this._(
          parentNavigatorKey: parentNavigatorKey,
          name: name,
          path: path,
          pageBuilder: (context, state) => ModalBottomSheetPage(
            builder: (context) => screenBuilder(context, state),
          ),
        );
}

class ModalBottomSheetPage<T> extends Page<T> {
  const ModalBottomSheetPage({
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute(
      settings: this,
      builder: builder,
      isScrollControlled: true,
    );
  }
}

import 'package:bom_hamburguer/router/routes.dart';
import 'package:bom_hamburguer/ui/home/home_screen.dart';
import 'package:bom_hamburguer/ui/resume/resume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Router
final Provider<GoRouter> router = Provider<GoRouter>(
  (ProviderRef<GoRouter> ref) => GoRouter(
    initialLocation: home,
    routes: <RouteBase>[
      GoRoute(
        path: home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),

      GoRoute(
        path: resume,
        builder: (BuildContext context, GoRouterState state) {
          return ResumeScreen();
        },
      ),
    ],
  ),
);

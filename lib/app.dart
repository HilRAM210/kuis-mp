import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/products/controllers/favorite_controller.dart';
import 'features/products/data/favorited_item_seeder.dart';
import 'features/products/screens/favorite_screen.dart';
import 'features/products/screens/product_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis 1 - Toko Hewan',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      // Kunci light mode: card putih + teks ink eksplisit tidak
      // dirancang untuk dark mode sistem.
      themeMode: ThemeMode.light,
      home: const AppShell(),
    );
  }
}

/// Shell bottom bar: Tab produk + favorit.
/// Detail dibuka via push dari ProductCard.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final FavoriteController favorites;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    favorites = FavoriteController(
      initialIds: dummyFavoriteItems.map((e) => e.product.id).toSet(),
    );
  }

  @override
  void dispose() {
    favorites.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          ProductListScreen(favorites: favorites),
          FavoriteScreen(favorites: favorites),
        ],
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: favorites,
        builder: (context, _) {
          return BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.store_outlined),
                activeIcon: Icon(Icons.store),
                label: 'Produk',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: favorites.count > 0,
                  label: Text('${favorites.count}'),
                  child: const Icon(Icons.favorite_border),
                ),
                activeIcon: Badge(
                  isLabelVisible: favorites.count > 0,
                  label: Text('${favorites.count}'),
                  child: const Icon(Icons.favorite),
                ),
                label: 'Favorit',
              ),
            ],
          );
        },
      ),
    );
  }
}

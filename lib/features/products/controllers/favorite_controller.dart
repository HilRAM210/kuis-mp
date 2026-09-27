import 'package:flutter/foundation.dart';

import '../data/product_seeder.dart';
import '../models/product.dart';

class FavoriteController extends ChangeNotifier {
  final Set<String> _ids;

  FavoriteController({Set<String>? initialIds}) : _ids = {...?initialIds};

  bool isFavorite(String id) => _ids.contains(id);

  void toggle(Product product) {
    if (_ids.contains(product.id)) {
      _ids.remove(product.id);
    } else {
      _ids.add(product.id);
    }
    notifyListeners();
  }

  List<Product> get favorites =>
      dummyProducts.where((p) => _ids.contains(p.id)).toList();

  int get count => _ids.length;
}

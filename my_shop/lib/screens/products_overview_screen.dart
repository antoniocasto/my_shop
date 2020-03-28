import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {},
            ),
            builder: (_, cart, cld) => Badge(
              child: cld,
              value: cart.itemCount.toString(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ProductsGrid(_showOnlyFavorites),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/product.dart';
import 'package:provider/provider.dart';

import 'package:my_shop/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // });

  @override
  Widget build(BuildContext context) {
    //Alternativamente ho usato il Consumer
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            //Ho ridotto l'area di rebuilding in caso di cambiamento
            //solo al widget del leading
            //mi risparmio il rebuilding del resto dell'interfaccia
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).accentColor,
            ),
            //child e' un widget che posso usare dentro il builder
            //(parametro child) e costituisce un elemento dell'interfaccia
            //che non dovra' mai essere rebuildato dentro il Consumer
            //child: Text('Never changes!'),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context)
                  .hideCurrentSnackBar(); //Nasconde snackbar corrente se in gia' in esecuzione
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Added item to cart!',
                ),
                duration: Duration(
                  seconds: 2,
                ),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () => cart.removeSingleItem(product.id),
                ),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

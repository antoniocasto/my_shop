import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';

import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen({@required this.title});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      /* L'attributo listen è fondamentale in quanto,
        poichè il metodo build viene richiamato ogni volta che abbiamo nuovi dati
        nel provider Products (ad es. _items aggiornato),
        esso permette, se settato a false, di non reagire alla notifica.
        Ad es. in questo caso, se viene aggiunto un nuovo prodotto,
        ha senso che il build del prodotto di questa schermata non venga richiamato
        in quanto il prodotto è rimasto lo stesso.
       */
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

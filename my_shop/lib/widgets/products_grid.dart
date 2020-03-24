import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import 'package:my_shop/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
        //Alternativa se non si usa il context
        //e' usare ChangeNotifierProvider.value(value: products[index], child:ProductItem())
        //context in create la metto diversa
        create: (c) => products[index],
        child: ProductItem(
            //Non piu necessari.
            /* 
              Abbiamo deciso di creare un provider Product
              per ogni product i della lista. Questo permette
              di evitare il passaggio di parametri e di tenere i dati
              ordinati avendo un provider per ogni singol Product.
            */
            // id: products[index].id,
            // title: products[index].title,
            // imageUrl: products[index].imageUrl,
            ),
      ),
    );
  }
}

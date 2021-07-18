import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

import 'package:zendy_app/models/models.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    final productId = product.id.toString();

    return InkWell(
      onTap: () => Get.toNamed('/title', arguments: productId),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      product.imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(
                      () => CircleAvatar(
                        backgroundColor: Colors.white,
                        child: new Material(
                          color: Colors.transparent,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            icon: product.isFavorite.value
                                ? Pulse(
                                    key: UniqueKey(),
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(Icons.favorite_rounded),
                                  )
                                : Pulse(
                                    key: UniqueKey(),
                                    duration: Duration(milliseconds: 200),
                                    child: Icon(Icons.favorite_border),
                                  ),
                            onPressed: () {
                              product.isFavorite.toggle();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              if (product.rating != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.rating.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 8),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'avenir',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

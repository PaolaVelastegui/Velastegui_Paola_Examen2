import 'dart:async';
import 'package:app_sistema_ventas/widgets/main_drawer.dart';
import 'package:app_sistema_ventas/models/products_model.dart';
import 'package:app_sistema_ventas/pages/page_pedidos.dart';
import 'package:app_sistema_ventas/services/service_products.dart';
import 'package:app_sistema_ventas/widgets/wave_clip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _productsModel = <ProductsModel>[];
  List<ProductsModel>? _listCart = [];

  ProductService dbproducts = new ProductService();

  StreamSubscription<QuerySnapshot>? subProduct;

  @override
  void initState() {
    super.initState();
    subProduct?.cancel();
    dbproducts = ProductService();
    dbproducts.initialiase();
    dbproducts.getProductList().then((value) => {
          setState(() {
            _productsModel = value;
          })
        });
  }

  @override
  void dispose() {
    subProduct?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 38,
                    ),
                    if (_listCart!.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listCart!.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (_listCart!.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(_listCart!),
                      ),
                    );
                },
              ),
            )
          ],
        ),
        drawer: const mainDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    WaveClip(),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 24, top: 48),
                      height: 150,
                      child: ListView.builder(
                        itemCount: _productsModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                height: 300,
                                padding: new EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '${_productsModel[index].image}' +
                                                '?alt=media',
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) {
                                          return Center(
                                              child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ));
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(height: 3.0, color: Colors.grey),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: _productsModel.length,
                      itemBuilder: (context, index) {
                        final String imagen = _productsModel[index].image;
                        var item = _productsModel[index];
                        return Card(
                            elevation: 4.0,
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${_productsModel[index].image}' +
                                                  '?alt=media',
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                              radius: 15,
                                            ));
                                          }),
                                    ),
                                    Text(
                                      '${_productsModel[index].name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          '${_productsModel[index].price.toString()} \$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23.0,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child: (!_listCart!
                                                      .contains(item))
                                                  ? (item.maxQuantity != 0)
                                                      ? Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.green,
                                                          size: 38,
                                                        )
                                                      : Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.red,
                                                          size: 38,
                                                        )
                                                  : Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.blue,
                                                      size: 38,
                                                    ),
                                              onTap: () {
                                                setState(() {
                                                  if (item.maxQuantity != 0) {
                                                    if (!_listCart!
                                                        .contains(item))
                                                      _listCart!.add(item);
                                                    else
                                                      _listCart!.remove(item);
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    )),
              ],
            ),
          )),
        ));
  }

  GridView _cuadroProductos() {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _productsModel.length,
      itemBuilder: (context, index) {
        final String imagen = _productsModel[index].image;
        var item = _productsModel[index];
        return Card(
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new Image.asset("assets/images/$imagen",
                          fit: BoxFit.contain),
                    ),
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          item.price.toString() + '\$',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!_listCart!.contains(item))
                                  ? Icon(
                                      Icons.shopping_cart,
                                      color: Colors.green,
                                      size: 38,
                                    )
                                  : Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!_listCart!.contains(item))
                                    _listCart!.add(item);
                                  else
                                    _listCart!.remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ));
      },
    );
  }
}

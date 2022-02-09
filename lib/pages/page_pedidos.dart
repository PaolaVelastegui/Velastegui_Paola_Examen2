import 'package:app_sistema_ventas/models/products_model.dart';
import 'package:app_sistema_ventas/pages/page_home.dart';
import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  final List<ProductsModel> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enable = false;

  List<ProductsModel> _cart;

  Container pagoTotal(List<ProductsModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          // Text("Total:  \$${valorTotal(_cart)}",
          //Text("Total:  ",
          Text("Total:  \$${valorTotal(_cart)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<ProductsModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + listaProductos[i].price * listaProductos[i].quantity;
    }

    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text('Pedidos',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enable && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enable) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String imagen = _cart[index].image;
                  var item = _cart[index];
                  //item.quantity = 0;
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: new Image.network("$imagen",
                                      fit: BoxFit.contain),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(item.name,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.black,
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.all(2.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  _removeProduct(index);
                                                  valorTotal(_cart);
                                                  // print(_cart);
                                                },
                                                color: Colors.white,
                                              ),
                                              Text('${_cart[index].quantity}',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0,
                                                      color: Colors.white)),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  _addProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                color: Colors
                                                    .white, // print(_cart);
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 38.0,
                                ),
                                Text(item.price.toString() + '\$',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                        color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.purple,
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text(
                    'Pagar',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (_) => AssetGiffDialog(
                        image: Image.asset(
                          'assets/images/reloj.gif',
                          fit: BoxFit.contain,
                        ),
                        title: const Text(
                          'Completar el pago de su carrito',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.w500),
                        ),
                        entryAnimation: EntryAnimation.bottomRight,
                        description: const Text(
                          'Estas a punto de terminar la compra, si deseas seguir al pago presiona OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15.0),
                        ),
                        onOkButtonPressed: () {
                          msgListaPedido();
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyHomePage(title: 'Inicio')));
                        },
                      ),
                    )
                  },
                ),
              ),
            ],
          ))),
    );
  }

  _addProduct(int index) {
    setState(() {
      if (_cart[index].maxQuantity != _cart[index].quantity) {
        _cart[index].quantity++;
      }
    });
  }

  _removeProduct(int index) {
    setState(() {
      if (_cart[index].quantity != 1) {
        _cart[index].quantity--;
      }
    });
  }

  void msgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = pedido + "FECHA:" + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "MEGA DESCUENTOS A DOMICILIO";
    pedido = pedido + "\n";
    pedido = pedido + "CLIENTE: FLUTTER - DART";
    pedido = pedido + "\n";
    pedido = pedido + "_____________";

    for (int i = 0; i < _cart.length; i++) {
      pedido = '$pedido' +
          "\n" +
          "Producto : " +
          _cart[i].name +
          "\n" +
          "Cantidad: " +
          _cart[i].quantity.toString() +
          "\n" +
          "Precio : " +
          _cart[i].price.toString() +
          "\n" +
          "\_________________________\n";
    }
    pedido = pedido + "TOTAL:" + valorTotal(_cart);
    _CartState(_cart = []);
    await launch("https://wa.me/${'5930962939990'}?text=$pedido");
  }
}

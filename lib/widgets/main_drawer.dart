import 'package:app_sistema_ventas/pages/login_page.dart';
import 'package:app_sistema_ventas/pages/page_home.dart';
import 'package:app_sistema_ventas/pages/page_productos.dart';
import 'package:flutter/material.dart';
import 'package:app_sistema_ventas/pages/page_main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class mainDrawer extends StatelessWidget {
  const mainDrawer({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //C1:57:3C:43:1B:B2:8E:6D:C2:A6:51:CD:8C:C4:34:44:22:6F:1D:9F
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      child: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.grey[850],
          child: new ListView(
            padding: EdgeInsets.only(top: 50.0),
            children: <Widget>[
              Container(
                height: 120,
                child: new UserAccountsDrawerHeader(
                  accountName: new Text(''),
                  accountEmail: new Text(''),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
              new Divider(),
              new ListTile(
                title: new Text(
                  'Inicio',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: new Icon(
                  Icons.home,
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyHomePage(title: 'Inicio'),
                )),
              ),
              new Divider(),
              new ListTile(
                title: new Text(
                  'Produtos',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: new Icon(
                  Icons.fastfood,
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen(),
                )),
              ),
              new Divider(),
              new ListTile(
                title: new Text(
                  'QR Code',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: new FaIcon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => MainPage(),
                )),
              ),
              new Divider(),
              new ListTile(
                title: new Text(
                  'Cerrar Sesion',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: new FaIcon(
                  FontAwesomeIcons.lock,
                  color: Colors.white,
                  size: 30.0,
                ),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                )),
              ),
              new Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

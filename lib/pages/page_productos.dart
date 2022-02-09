import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        children: [_buildList()],
      ),
    );
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Productos").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Expanded(
            child: Container(
              child: ListView(
                children: _getProductsWidget(snapshot),
              ),
            ),
          );
        }
      },
    );
  }

  List<Widget> _getProductsWidget(dynamic snapshot) {
    final List<Widget> widgets = [];

    for (final items in snapshot.data.docs) {
      Map<String, dynamic> item = items.data();
      final String image = item["image"];

      widgets.add(_buildProductItem(items.id, item["name"], item["image"]));
    }
    return widgets;
  }

  Widget _buildProductItem(String productId, String name, String description) {
    return Card(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name, style: TextStyle(fontSize: 18)),
                Spacer(flex: 1),
              ],
            ),
            Text(description, style: TextStyle(fontSize: 14)),
            Image.network('$description')
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Icon(icon),
      ),
      onTap: onTap,
    );
  }
}


import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import '../model/menu_model.dart'; // Import the MenuModel

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final MenuModel _menuModel = MenuModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 232, 168, 7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.orange),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _menuModel.buildMenuItem(
                    'Promotions',
                    'assets/promotions.jpg',
                    '10 items',
                    () {
                      // Handle Promotions tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Beverages',
                    'assets/beverages.jpg',
                    '20 items',
                    () {
                      // Handle Beverages tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Food',
                    'assets/food.jpg',
                    '120 items',
                    () {
                      // Handle Food tap
                    },
                  ),
                  _menuModel.buildMenuItem(
                    'Dessert',
                    'assets/dessert.jpg',
                    '10 items',
                    () {
                      // Handle Dessert tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orangeAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.orangeAccent),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.orangeAccent),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.orangeAccent),
            label: 'Profile',
          ),
        ],
        currentIndex: _menuModel.selectedIndex,
        onTap: (index) {
          setState(() {
            _menuModel.onItemTapped(index, context);
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.orange[50],
      ),
    );
  }
}

// Assume that MenuModel is properly defined elsewhere
// For instance, MenuModel could look something like this:

class MenuModel {
  int selectedIndex = 1;

  void onItemTapped(int index, BuildContext context) {
    selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CartScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  Widget buildMenuItem(String title, String imagePath, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5.0,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
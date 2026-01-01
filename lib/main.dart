import 'package:flutter/material.dart';

class Product {
  final String title;
  final String price;
  final double priceValue;
  final String weight;
  final String image;
  final String description;

  Product({
    required this.title,
    required this.price,
    required this.priceValue,
    required this.weight,
    required this.image,
    required this.description,
  });
}

void main() {
  runApp( GroceryApp());
}

const Color kPrimaryColor = Color(0xFF00C569);
const Color kBackgroundColor = Color(0xFFF5F5F8);

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eGrocery',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
      ),
      home:  MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  List<Product> cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        cartItems: cartItems,
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart,
      ),
       MenuScreen(),
      CartScreenContent(cartItems: cartItems, onRemoveItem: _removeFromCart, isPage: false),
       Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      drawer:  Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Name"),
            ),
          ],
        ),
      ),

      body: screens[_selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _selectedIndex = 2),
        backgroundColor: kPrimaryColor,
        shape:  CircleBorder(),
        child: Stack(
          alignment: Alignment.center,
          children: [
             Icon(Icons.shopping_basket, color: Colors.white),
            if (cartItems.isNotEmpty)
              Positioned(
                right: 0, top: 0,
                child: Container(
                  padding:  EdgeInsets.all(4),
                  decoration:  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(cartItems.length.toString(), style:  TextStyle(fontSize: 10, color: Colors.white)),
                ),
              )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape:  CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, "Home", 0),
              _buildNavItem(Icons.grid_view, "Menu", 1),
               SizedBox(width: 40),
              _buildNavItem(Icons.bookmark_border, "Save", 2),
              _buildNavItem(Icons.person_outline, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? kPrimaryColor : Colors.grey),
          Text(label, style: TextStyle(fontSize: 12, color: isSelected ? kPrimaryColor : Colors.grey)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Product> cartItems;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart;

   HomeScreen({
    super.key,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart
  });

  @override
  Widget build(BuildContext context) {
    final productApple = Product(
      title: "Organic Red Apple",
      price: "\$3.50", priceValue: 3.50, weight: "1kg",
      image: "https://cdn-icons-png.flaticon.com/512/415/415733.png",
      description: "Fresh, crisp, and sweet organic red apples, perfect for snacking or baking.",
    );

    final productMeat = Product(
      title: "Fresh Meat",
      price: "\$45.00", priceValue: 45.00, weight: "2kg",
      image: "https://cdn-icons-png.flaticon.com/512/3143/3143643.png",
      description: "Premium quality fresh meat.",
    );

    final productBundle = Product(
      title: "Bundle Pack",
      price: "\$35.00", priceValue: 35.00, weight: "3kg",
      image: "https://cdn-icons-png.flaticon.com/512/5029/5029236.png",
      description: "A complete bundle containing Onions, Oil, and Salt.",
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon:  Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.shopping_cart_outlined, color: kPrimaryColor),
             SizedBox(width: 8),
            RichText(
              text:  TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: [
                  TextSpan(text: "e", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  TextSpan(text: "Grocery", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(icon:  Icon(Icons.search, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding:  EdgeInsets.all(20),
              decoration: BoxDecoration(color:  Color(0xFFE3FCEF), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order your\nDaily Groceries", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3C52))),
                        SizedBox(height: 8),
                        Text("#Free Delivery", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Image.network("https://cdn-icons-png.flaticon.com/512/3082/3082011.png", height: 80),
                ],
              ),
            ),
             SizedBox(height: 20),

            _buildSectionHeader("Popular Packs"),
             SizedBox(height: 10),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard(context, productBundle),
                  _buildProductCard(context, productApple),
                ],
              ),
            ),

             SizedBox(height: 20),
            _buildSectionHeader("Our New Item"),
             SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildProductCard(context, productApple)),
                Expanded(child: _buildProductCard(context, productMeat)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
         Text("View All", style: TextStyle(color: kPrimaryColor)),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductDetailScreen(
              product: product,
              cartItems: cartItems,
              onAddToCart: onAddToCart,
              onRemoveFromCart: onRemoveFromCart,
            ))
        );
      },
      child: Container(
        width: 160,
        margin:  EdgeInsets.only(right: 16, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10,
              offset:  Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Padding(padding:  EdgeInsets.all(12.0), child: Image.network(product.image, height: 80))),
            Padding(padding:  EdgeInsets.symmetric(horizontal: 12), child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Padding(padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Text(product.weight, style: TextStyle(color: Colors.grey[500], fontSize: 12))),
            Padding(
              padding:  EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.price, style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   Icon(Icons.add_circle, color: kPrimaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategoryIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {"name": "Vegetables", "icon": Icons.eco},
    {"name": "Meat And Fish", "icon": Icons.set_meal},
    {"name": "Medicine", "icon": Icons.medication},
    {"name": "Baby Care", "icon": Icons.child_care},
    {"name": "Office Supplies", "icon": Icons.edit},
    {"name": "Beauty", "icon": Icons.face},
    {"name": "Gym", "icon": Icons.fitness_center},
    {"name": "Gardening", "icon": Icons.grass},
    {"name": "Pack", "icon": Icons.shopping_bag},
    {"name": "Others", "icon": Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Choose a category"), centerTitle: true),
      body: GridView.builder(
        padding:  EdgeInsets.all(16),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.8, crossAxisSpacing: 16, mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Column(
              children: [
                Container(
                  height: 70, width: 70,
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimaryColor : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
                  ),
                  child: Icon(cat['icon'] as IconData, color: isSelected ? Colors.white : Colors.black, size: 28),
                ),
                 SizedBox(height: 8),
                Text(cat['name'] as String, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: isSelected ? kPrimaryColor : Colors.grey[700], fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final List<Product> cartItems;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart
  });

  void _openCartAsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title:  Text("My Cart"), centerTitle: true),
          body: CartScreenContent(
              cartItems: cartItems,
              onRemoveItem: onRemoveFromCart,
              isPage: true
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text("Product Details", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme:  IconThemeData(color: Colors.black),
        actions: [IconButton(onPressed: (){}, icon:  Icon(Icons.favorite_border))],
      ),
      bottomNavigationBar: Container(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10,
                offset:  Offset(0, -5))]
        ),
        child: SafeArea(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _openCartAsPage(context),
                child: Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                       Icon(Icons.shopping_cart_outlined, color: Colors.black),
                      if (cartItems.isNotEmpty)
                        Positioned(right: 8, top: 8, child: CircleAvatar(radius: 4, backgroundColor: Colors.red)),
                    ],
                  ),
                ),
              ),
               SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      onAddToCart(product);
                      _openCartAsPage(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child:  Text("Buy Now", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280, width: double.infinity,
              color:  Color(0xFFE3FCEF).withOpacity(0.5),
              child: Padding(padding:  EdgeInsets.all(40.0),
                  child: Image.network(product.image)),
            ),
            Padding(
              padding:  EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, style:  TextStyle(fontSize: 22,
                      fontWeight: FontWeight.bold)),
                   SizedBox(height: 8),
                  Text("Weight: ${product.weight}", style:  TextStyle(color: Colors.grey)),
                   SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           Text("\$5.00", style: TextStyle(decoration: TextDecoration.lineThrough,
                               color: Colors.grey, fontSize: 18)),
                           SizedBox(width: 10),
                          Text(product.price, style:  TextStyle(color: kPrimaryColor,
                              fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          _buildQtyBtn(Icons.remove),
                           Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text("1", style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                          _buildQtyBtn(Icons.add),
                        ],
                      )
                    ],
                  ),
                   SizedBox(height: 24),
                   Text("Product Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                   SizedBox(height: 8),
                  Text(product.description, style: TextStyle(color: Colors.grey[600], height: 1.5)),
                   SizedBox(height: 20),
                   Row(
                    children: [
                      Text("Review", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 16, color: Colors.black),
    );
  }
}

class CartScreenContent extends StatelessWidget {
  final List<Product> cartItems;
  final Function(Product) onRemoveItem;
  final bool isPage;

  const CartScreenContent({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.isPage,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = cartItems.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("Your Cart is Empty", style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      ),
    )
        : Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding:  EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Container(
                margin:  EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 80, height: 80,
                      padding:  EdgeInsets.all(8),
                      decoration: BoxDecoration(color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.network(item.image),
                    ),
                     SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style:  TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 16)),
                           SizedBox(height: 4),
                          Text(item.weight, style: TextStyle(color: Colors.grey[500],
                              fontSize: 12)),
                           SizedBox(height: 8),
                          Row(
                            children: [
                              _buildQtyBtn(Icons.remove),
                               Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                   child: Text("1")),
                              _buildQtyBtn(Icons.add),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(icon:  Icon(Icons.close, color: Colors.grey),
                            onPressed: () => onRemoveItem(item)),
                         SizedBox(height: 10),
                        Text(item.price, style:  TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding:  EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10,
                  offset:  Offset(0, -5))]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Total Price", style: TextStyle(fontSize: 18,
                       fontWeight: FontWeight.bold)),
                  Text("\$${cartItems.fold(0.0, (sum, item) => sum +
                      item.priceValue).toStringAsFixed(2)}", style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
               SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child:  Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        )
      ],
    );

    if (!isPage) {
      return Scaffold(
        appBar: AppBar(title:  Text("My Cart"), centerTitle: true),
        body: content,
      );
    }

    return content;
  }

  Widget _buildQtyBtn(IconData icon) {
    return Container(
      padding:  EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 16, color: kPrimaryColor),
    );
  }
}
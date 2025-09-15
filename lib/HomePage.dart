import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'intropage.dart'; // ✅ Corrected import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _featuredController =
      PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<Map<String, String>> featuredProducts = const [
    {
      'image':
          'https://images.unsplash.com/photo-1562349486-3355f0c8cefa?q=80&w=988&auto=format&fit=crop',
      'titleKey': 'red_dress',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1614786269829-d24616faf56d?q=80&w=1035&auto=format&fit=crop',
      'titleKey': 'formal_suit',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1571601035754-5c927f2d7edc?q=80&w=987&auto=format&fit=crop',
      'titleKey': 'sneakers',
    },
  ];

final List<Map<String, String>> products = const [
  {
    'image': 'https://images.unsplash.com/photo-1631234764568-996fab371596?q=80&w=987&auto=format&fit=crop',
    'titleKey': 'white_dress',
    'priceKey': 'price_white_dress',
  },
  {
    'image': 'https://images.unsplash.com/photo-1596783074918-c84cb06531ca?q=80&w=987&auto=format&fit=crop',
    'titleKey': 'basic_dress',
    'priceKey': 'price_basic_dress',
  },
  {
    'image': 'https://images.unsplash.com/photo-1542272604-787c3835535d?q=80&w=1626&auto=format&fit=crop',
    'titleKey': 'jeans',
    'priceKey': 'price_jeans',
  },
  {
    'image': 'https://images.unsplash.com/photo-1589413364939-9f9fedb13e20?q=80&w=987&auto=format&fit=crop',
    'titleKey': 'sweatpants',
    'priceKey': 'price_sweatpants',
  },
  {
    'image': 'https://images.unsplash.com/photo-1618085219724-c59ba48e08cd?q=80&w=987&auto=format&fit=crop',
    'titleKey': 'white_chemise',
    'priceKey': 'price_white_chemise',
  },
  {
    'image': 'https://images.unsplash.com/photo-1603487742131-4160ec999306?q=80&w=987&auto=format&fit=crop',
    'titleKey': 'slippers',
    'priceKey': 'price_slippers',
  },
];


  final List<Map<String, String>> hotOffers = const [
    {
      'image':
          'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?q=80&w=2072&auto=format&fit=crop',
      'promoKey': 'promo_50',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1491553895911-0055eca6402d?q=80&w=1480&auto=format&fit=crop',
      'promoKey': 'promo_bogo',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1645207803533-e2cfe1382f2c?q=80&w=987&auto=format&fit=crop',
      'promoKey': 'promo_new',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1549298916-b41d501d3772?q=80&w=2012&auto=format&fit=crop',
      'promoKey': 'promo_limited',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1665521032636-e8d2f6927053?q=80&w=2070&auto=format&fit=crop',
      'promoKey': 'promo_ship',
    },
  ];

  @override
  void initState() {
    super.initState();
    _featuredController.addListener(() {
      setState(() {
        _currentPage = _featuredController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _featuredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("our_products")),
        centerTitle: true,
        actions: [
          // 🌐 Language toggle (always fixed on right)
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black),
            onPressed: () {
              if (isArabic) {
                context.setLocale(const Locale('en', 'US'));
              } else {
                context.setLocale(const Locale('ar', 'EG'));
              }
            },
          ),

          // ☰ Hamburger menu with logout
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (value) {
              if (value == 'logout') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(tr("logout_success")),
                  ),
                );
                // ✅ Navigate to IntroPage on logout
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Intropage()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(tr("logout")),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Featured Products Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                tr("featured_products"),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 260,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _featuredController,
                    itemCount: featuredProducts.length,
                    itemBuilder: (context, index) {
                      final product = featuredProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(product['image']!, fit: BoxFit.cover),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.all(10),
                                color: Colors.black45,
                                child: Text(
                                  tr(product['titleKey']!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  /// Left Arrow
                  Positioned(
                    top: 100,
                    left: 5,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_circle_left, size: 40),
                      color: const Color.fromARGB(221, 97, 0, 0),
                      onPressed: () {
                        if (_currentPage > 0) {
                          _featuredController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),

                  /// Right Arrow
                  Positioned(
                    top: 100,
                    right: 5,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_circle_right, size: 40),
                      color: const Color.fromARGB(221, 97, 0, 0),
                      onPressed: () {
                        if (_currentPage < featuredProducts.length - 1) {
                          _featuredController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Page Indicator (Dots)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredProducts.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Product Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              product['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tr(product['titleKey']!),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  
                                  IconButton(
                                    icon: const Icon(Icons.add_shopping_cart),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(tr("item_added_cart")),
                                          duration:
                                              const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),

                              
                              Text(
                                tr("price_${product['titleKey']}"),
                                style: const TextStyle(fontSize: 17,color: Color.fromARGB(255, 74, 74, 74)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Hot Offers Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "🔥 ${tr("hot_offers")}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: hotOffers.length,
              itemBuilder: (context, index) {
                final offer = hotOffers[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(offer['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: isArabic ? null : 16,
                        right: isArabic ? 16 : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tr(offer['promoKey']!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

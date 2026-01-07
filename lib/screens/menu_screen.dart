import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_item_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Track cart items with their quantities
  final Map<String, int> _cartItems = {};

  int get _totalItems =>
      _cartItems.values.fold(0, (sum, quantity) => sum + quantity);

  int get _totalPrice {
    int total = 0;
    _cartItems.forEach((id, quantity) {
      final item = sampleMenuItems.firstWhere((item) => item.id == id);
      total += item.price * quantity;
    });
    return total;
  }

  void _addToCart(String itemId) {
    setState(() {
      _cartItems[itemId] = (_cartItems[itemId] ?? 0) + 1;
    });
  }

  void _removeFromCart(String itemId) {
    setState(() {
      if (_cartItems.containsKey(itemId)) {
        if (_cartItems[itemId]! > 1) {
          _cartItems[itemId] = _cartItems[itemId]! - 1;
        } else {
          _cartItems.remove(itemId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverAppBar(
                pinned: true,
                floating: false,
                backgroundColor: isDark
                    ? AppTheme.backgroundDark.withOpacity(0.95)
                    : AppTheme.backgroundLight.withOpacity(0.95),
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Go back',
                ),
                title: const Text('Main Dishes'),
                actions: [
                  // Cart button
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          // TODO: Navigate to cart
                        },
                        icon: const Icon(Icons.shopping_cart),
                        tooltip: 'View cart',
                      ),
                      if (_totalItems > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$_totalItems',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 4),
                ],
              ),

              // Header section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recommended',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppTheme.textPrimaryDark
                              : AppTheme.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Popular choices among locals.',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppTheme.textSecondaryDark
                              : AppTheme.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Menu items list
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = sampleMenuItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MenuItemCard(
                          item: item,
                          quantity: _cartItems[item.id] ?? 0,
                          onAdd: () => _addToCart(item.id),
                          onRemove: () => _removeFromCart(item.id),
                        ),
                      );
                    },
                    childCount: sampleMenuItems.length,
                  ),
                ),
              ),
            ],
          ),

          // Floating order button
          if (_totalItems > 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      (isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight)
                          .withOpacity(0),
                      (isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight)
                          .withOpacity(0.9),
                      isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
                    ],
                    stops: const [0, 0.3, 1],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Material(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 8,
                  shadowColor: AppTheme.primary.withOpacity(0.4),
                  child: InkWell(
                    onTap: () {
                      // TODO: Navigate to order screen
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          // Item count badge
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$_totalItems',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'View Order',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.015,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '$_totalPrice THB',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.015,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

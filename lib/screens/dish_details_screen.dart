import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishDetailsScreen extends StatefulWidget {
  const DishDetailsScreen({super.key});

  @override
  State<DishDetailsScreen> createState() => _DishDetailsScreenState();
}

class _DishDetailsScreenState extends State<DishDetailsScreen> {
  int _selectedSpiceLevel = 2; // Default to Medium
  int _quantity = 1;
  final Set<int> _selectedExtras = {};
  final TextEditingController _noteController = TextEditingController();
  bool _isFavorite = false;

  static const Color primaryColor = Color(0xFFF46A25);
  static const Color backgroundDark = Color(0xFF221610);
  static const Color surfaceDark = Color(0xFF2C241F);

  final List<Map<String, dynamic>> _extras = [
    {
      'name': 'Extra Prawns (2pcs)',
      'description': 'Fresh river prawns',
      'price': 40,
    },
    {
      'name': 'Fried Egg',
      'description': 'Crispy edges',
      'price': 15,
    },
    {
      'name': 'Extra Peanuts',
      'description': 'Roasted & crushed',
      'price': 5,
    },
  ];

  int get _basePrice => 120;

  int get _totalPrice {
    int extrasTotal = 0;
    for (var index in _selectedExtras) {
      extrasTotal += _extras[index]['price'] as int;
    }
    return (_basePrice + extrasTotal) * _quantity;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            slivers: [
              // Hero Image Section
              SliverToBoxAdapter(
                child: _buildHeroSection(),
              ),
              // Main Content
              SliverToBoxAdapter(
                child: _buildMainContent(),
              ),
              // Bottom padding for sticky bar
              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),
          // Sticky Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          // Main Image
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCmVXAw6XE7MolVVoSXDZR1V_rzonSwet2BGTQKQJJGxiN_JgxRFjaQiIu759pP6vTgBjlqHFh0Ylk2cN30VIgwAHyvrfIz3vgW1UniiiQFMMJ9iwHbKUuZZJ0i1oS2dsj1F2i7tBMXYdLvMudRIyM-TfCGj3tBTA3c_wJsx_iS-fsaCGNAQYkIMv-tH_Scy4XByst8HyG19176PWlT-0akka1IItriwLz1VK8Tzsv5Ba7N_JEetiyxZkdZKl5PsYO2537pndrGtjpk',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: surfaceDark,
                  child: const Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 80,
                      color: primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.transparent,
                    backgroundDark.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // Top Navigation Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                _buildCircleButton(
                  icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.2),
      shape: const CircleBorder(
        side: BorderSide(color: Colors.white10),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            _buildHeaderInfo(),
            const SizedBox(height: 16),
            // Meta Tags
            _buildMetaTags(),
            const SizedBox(height: 24),
            // Description
            _buildDescription(),
            const SizedBox(height: 32),
            // Divider
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.1),
            ),
            const SizedBox(height: 32),
            // Spiciness Selector
            _buildSpicinessSelector(),
            const SizedBox(height: 32),
            // Extra Toppings
            _buildExtraToppings(),
            const SizedBox(height: 32),
            // Note to Chef
            _buildNoteToChef(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Pad Thai Kung Sod',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '฿$_basePrice',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'ผัดไทยกุ้งสด',
          style: GoogleFonts.notoSansThai(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaTags() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        // Rating Tag
        _buildTag(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 18,
                color: Color(0xFFF97316),
              ),
              const SizedBox(width: 6),
              const Text(
                '4.8',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFF7ED),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(128)',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFFFDBA74).withOpacity(0.6),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFF97316).withOpacity(0.1),
          borderColor: const Color(0xFFF97316).withOpacity(0.2),
        ),
        // Time Tag
        _buildTag(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.schedule,
                size: 18,
                color: Color(0xFF9CA3AF),
              ),
              SizedBox(width: 6),
              Text(
                '15 min',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFCBD5E1),
                ),
              ),
            ],
          ),
          backgroundColor: surfaceDark,
          borderColor: Colors.white.withOpacity(0.05),
        ),
        // Calories Tag
        _buildTag(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.local_fire_department,
                size: 18,
                color: Color(0xFF9CA3AF),
              ),
              SizedBox(width: 6),
              Text(
                '450 kcal',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFCBD5E1),
                ),
              ),
            ],
          ),
          backgroundColor: surfaceDark,
          borderColor: Colors.white.withOpacity(0.05),
        ),
      ],
    );
  }

  Widget _buildTag({
    required Widget child,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }

  Widget _buildDescription() {
    return const Text(
      'The most famous Thai noodle dish. Classic stir-fried rice noodles with fresh river prawns, firm tofu, egg, roasted peanuts, and fresh bean sprouts. Served with a slice of lime and chili flakes on the side.',
      style: TextStyle(
        fontSize: 15,
        color: Color(0xFF94A3B8),
        height: 1.6,
      ),
    );
  }

  Widget _buildSpicinessSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Spiciness Level',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Required',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: surfaceDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildSpiceOption(0, Icons.block, 'Non', null),
              _buildSpiceOption(1, null, 'Mild', '🌶️'),
              _buildSpiceOption(2, null, 'Medium', '🌶️🌶️'),
              _buildSpiceOption(3, Icons.local_fire_department, 'Thai Hot', null, isHot: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpiceOption(int index, IconData? icon, String label, String? emoji, {bool isHot = false}) {
    final isSelected = _selectedSpiceLevel == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSpiceLevel = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3E3229) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ]
                : null,
            border: isSelected
                ? Border.all(color: Colors.white.withOpacity(0.1))
                : null,
          ),
          child: Column(
            children: [
              if (emoji != null)
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 18),
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 20,
                  color: isHot
                      ? const Color(0xFFEF4444)
                      : isSelected
                          ? Colors.white
                          : const Color(0xFF9CA3AF).withOpacity(0.5),
                ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isHot
                      ? const Color(0xFFEF4444)
                      : isSelected
                          ? (index == 0 ? Colors.white : primaryColor)
                          : const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtraToppings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Extras',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_extras.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index < _extras.length - 1 ? 12 : 0),
            child: _buildExtraItem(index),
          );
        }),
      ],
    );
  }

  Widget _buildExtraItem(int index) {
    final extra = _extras[index];
    final isSelected = _selectedExtras.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedExtras.remove(index);
          } else {
            _selectedExtras.add(index);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? primaryColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            // Custom Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? primaryColor : const Color(0xFF4B5563),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            // Item Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    extra['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    extra['description'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Text(
              '+฿${extra['price']}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteToChef() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Note to Chef',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Optional',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF).withOpacity(0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            TextField(
              controller: _noteController,
              maxLength: 100,
              maxLines: 4,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Anything else we should know? (e.g. No cilantro, less oil)',
                hintStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: surfaceDark,
                counterText: '',
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Text(
                '${_noteController.text.length}/100',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundDark.withOpacity(0),
            backgroundDark.withOpacity(0.95),
            backgroundDark,
          ],
          stops: const [0.0, 0.3, 0.5],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Row(
            children: [
              // Quantity Selector
              Container(
                width: 128,
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: _quantity > 1
                          ? () {
                              setState(() {
                                _quantity--;
                              });
                            }
                          : null,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Add to Cart Button
              Expanded(
                child: Material(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      // Add to cart action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added $_quantity item(s) to cart'),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 1,
                                height: 16,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '฿$_totalPrice',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final isEnabled = onPressed != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20,
            color: isEnabled ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}

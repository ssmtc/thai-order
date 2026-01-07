import 'package:flutter/material.dart';
import 'dish_details_screen.dart';

// Custom Colors matching the design
class AppColors {
  static const Color primary = Color(0xFFF46A25);
  static const Color backgroundDark = Color(0xFF221610);
  static const Color surfaceDark = Color(0xFF2F221C);
  static const Color textMuted = Color(0xFFBAA69C);
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedLanguage = 'JP';
  int selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Top App Bar
              SliverToBoxAdapter(child: _buildTopAppBar()),
              // Search Bar
              SliverToBoxAdapter(child: _buildSearchBar()),
              // Language Toggle
              SliverToBoxAdapter(child: _buildLanguageToggle()),
              // Chef's Recommendations
              SliverToBoxAdapter(child: _buildChefRecommendations()),
              // Menu Categories
              SliverToBoxAdapter(child: _buildMenuCategories()),
              // Bottom padding for navigation
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
          // Floating Cart Button
          _buildFloatingCartButton(),
          // Bottom Navigation
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.7),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sawasdee Thai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Table #5',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search dish (料理名で検索)...',
            hintStyle: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.textMuted,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.mic,
                color: AppColors.textMuted,
              ),
              onPressed: () {},
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            _buildLanguageButton('TH', 'ไทย'),
            _buildLanguageButton('EN', 'English'),
            _buildLanguageButton('JP', '日本語'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String code, String label) {
    final isSelected = selectedLanguage == code;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedLanguage = code;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChefRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Chef's Recommendations",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildRecommendationCard(
                'Tom Yum Goong',
                'Spicy Shrimp Soup / トムヤムクン',
                '฿180',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDTtLALi4GqYI_BMJMtpv5Jgyzjh1eSUGhXf4C-DOdsVnH1Nt1iQhT93pQPjBahVhgsJzRpNo-Z0P6-EO8YE3grWm5zSviu2Efw5LhVUMwoMg_OXn-atcEv-CSdzVYfOC67g-flWf5xRm_i19D2zQzaTpjYeHq3GMiCqMOXJ1NaGkekgi8dep64o06qsv7dfqM989ld9LlcP4mh9OQcpGCAhkdZ9ShdQbUhLtbjvm_rvkMQcDv_SztShS8BdzJRFz3TJxL2CI4B0kbJ',
                badge: 'Best Seller',
                badgeColor: AppColors.primary,
              ),
              const SizedBox(width: 16),
              _buildRecommendationCard(
                'Massaman Curry',
                'The King of Curries / マッサマンカレー',
                '฿220',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDZji-owtdcuAdhscnbsZoEVKYi-IovtZdSzFiiAFhE8AjRFNVKjKo5beEh6Z_WPOlp_Jx-xdHD7lEBzL5VnLKP76C1T-zPCYNjzxKFPAwSR4q2d4zNB_9ibFzWQ3AR-iI51g1moQOoPcOjwiZha-iyBLXss7YqxujsrYiKbi7X8alJpNgpkQjjdyr3sYtdYyv9Wjq1L8DT4c7f9-quBlacy49VYAa-LwE6q3gF_xi1mQMCIbGdNn-zh53kdfSyR1KHWrJwIJM0k3Os',
              ),
              const SizedBox(width: 16),
              _buildRecommendationCard(
                'Pad Thai',
                'Thai Fried Noodles / パッタイ',
                '฿120',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDxnaNRs7Bx3eZgIXRB1NTPBzEt6KTOsFlj2e9T5U92YW72DtUcLenGtWWD4RcatfxGGBjiKgKzVFm7Adxlj29SOZe5i8OQckp8wg00_80gdMrkcCm20mXd3nkt7e8o-7kndBAmBTFAecL5md8qTKEO-uvWiGf79PXbtnwnoT7mu1X47FYZIX2rl8upoFKTniWK5sg6iuA8jN4cWCp1XeuPlNI-zHhqkImZLy2rYhBTKxOoChdIp_fS9nfmSCbkpiNupWe7bp3i42Cf',
                badge: 'Vegan Option',
                badgeColor: Colors.green.shade600,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    String title,
    String subtitle,
    String price,
    String imageUrl, {
    String? badge,
    Color? badgeColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DishDetailsScreen(),
          ),
        );
      },
      child: Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.surfaceDark,
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          color: AppColors.textMuted,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (badge != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor ?? AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildMenuCategories() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.0,
            children: [
              _buildCategoryCard(
                'Curry',
                'カレー / แกง',
                Icons.soup_kitchen,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBmrq2WnvQy7xTajZaUd4jwuw-2yQnrocbhVUWHxfv_L7HZPtF7xeohOJbamrafzGotJTRHQp3XjuOKdxdmsZKY9pL1MZX1iX-3gvNaCH8LnHoi_6ZwoF4B8NlAUQy1letQoqgN6YQ1pBd_3Xb_8yRha64oCCYx3A7LhvHVzsR_tr8OssPnzUPlzFbgLqR39UtT3MNRIPzzcP2rK1SOp1Yao70akq6hOfpPFuxl6sN8EF8OEnGQIjqrixrJgwDgTFYNnC4LC4L0wWiy',
              ),
              _buildCategoryCard(
                'Noodles',
                '麺類 / ก๋วยเตี๋ยว',
                Icons.ramen_dining,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAf4wQ9MTHOFx_KsCGKOIbs4VNXDSHXCKReBVEuTc06H03-w8IzhUS-lVmndv_IIvJ60dvWLEWMyA1K_1g-5qGwKQk2SZrwAzEvNgI6CCr-X0LmE3VnJ5_zf5QkUAPrI4uvUam-yejcsjbWs2FniGAAyDmwxClhON7SnhTpAfgMfZziIXtzc4QSNrwXOCGvf7Ws99A4E6jaZuS1_qzwPCE-8af-bbteg2-2ILkJwJMb9-fl-WYhVIYsvJ0Oxcc8M92Nu0YCDc9R0x-O',
              ),
              _buildCategoryCard(
                'Stir-Fry',
                '炒め物 / ผัด',
                Icons.local_fire_department,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBNQaIEHJ2n6yYbcpVUa3NQsqi6dXK0-YXDcwUkeEgD0Sys0DnqvPoLLB2VlF8L0FmohvLPkGHA2iIw48XkKz63qz1kUMQzwZK8imk6cV4H-9EeqzY97faxcrWuYUAYYGg1TYX6lSGJIcW8QWJEJ7v7yE8nRYn30uiLHEIRKEZLErIWIiziBokbbYSR-WhdylwnXu-5MgeFroC_cVvdi8mZ9gWWqtpBmyGzrZQmOVqbvdfu1MoF4ywNyqHmVK9ZDPylZagxK9cNgbMY',
              ),
              _buildCategoryCard(
                'Rice Dishes',
                'ご飯もの / ข้าว',
                Icons.rice_bowl,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCGDe938tv-XBA2rwdkcIw__gQN-8LiqxdXxC5tMx2JKqSCyWtn6Z8CQs-N5MrnchS85IIA_ec4DzpY1rK1Gg_P3LllHMRMqPJyNwisNckfCtUzPwgi037TXEpW95FQhReliHNgp7JRVo8rw-2-aW1qTw3JVIU1sg0m0ONWvkfeOtZkaw7a0ziLQQvmql6WKfAQNj3WValDLWDxiOJWImrdSkMv-rtR87ouiPa8kDWdDtL8MDPFCSA1iuYcaL3QliVTaEjYaMTfrZsC',
              ),
              _buildCategoryCard(
                'Soups',
                'スープ / ต้ม',
                Icons.set_meal,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCVq31TwYFdMtlsr5NeqO8chBiQbtsS7YwFbDDxKbs3TlL6IlDGJ9R-aomiLXGqZ_pwhJffJf1t2E-ttOMW0vzhkVgyt6sg97W79EziYwikdrGqkN9iDX4lP_PNEOUA6ORF9Rq_bxeumHMC_jnA1BQ5VZWYMZJrhwQstGEkv_k-pmuaBrmATyAonwEoQLpbke13V4XNHeJj2GySRA_6a4FBuXyJZKqiZJHlPiaIOyHI_MdtPfeCGCxD4BNbuezwb6XG9PvPwLdNlRem',
              ),
              _buildCategoryCard(
                'Drinks & Sweets',
                'デザート・飲料',
                Icons.icecream,
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCb7YPbrTWQ2oRkZVzFAkDvtdsARaV4tpaG-ZFFz59hJB1tIydV0-5jEkyuOwdb19SsRmShURnVXF-hatyguEv2xiwjR6Z-qpwufc7e6hpEND0AF3ZmJDj4YC6r6JOKNQaUak0QV5C7LHxTbJqtoJ_pL57ExUPR2jPNZcUyHreZQvQYB3s281ea05_rOjutxxLeiaZS1llZYEmuRDtTlbgaw06czoG72zY1PKJKnnBxAf5okZUG6HojFYR8H1SyhuU-hWpGkOS52uzP',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    String subtitle,
    IconData icon,
    String imageUrl,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.surfaceDark,
                  child: Center(
                    child: Icon(
                      icon,
                      color: AppColors.textMuted,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCartButton() {
    return Positioned(
      bottom: 100,
      right: 16,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark.withOpacity(0.95),
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home, 'Home'),
                _buildNavItem(1, Icons.receipt_long, 'History'),
                _buildNavItem(2, Icons.payments, 'Bill'),
                _buildNavItem(3, Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNavIndex = index;
        });
      },
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

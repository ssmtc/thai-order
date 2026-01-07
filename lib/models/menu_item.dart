class MenuItem {
  final String id;
  final String nameThai;
  final String nameEnglish;
  final String description;
  final int price;
  final String imageUrl;
  final int spiceLevel; // 0-3 (0 = not spicy, 3 = very spicy)
  final String? badge; // e.g., "Best Seller", "New", etc.
  final String category;

  const MenuItem({
    required this.id,
    required this.nameThai,
    required this.nameEnglish,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.spiceLevel = 0,
    this.badge,
    required this.category,
  });

  MenuItem copyWith({
    String? id,
    String? nameThai,
    String? nameEnglish,
    String? description,
    int? price,
    String? imageUrl,
    int? spiceLevel,
    String? badge,
    String? category,
  }) {
    return MenuItem(
      id: id ?? this.id,
      nameThai: nameThai ?? this.nameThai,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      badge: badge ?? this.badge,
      category: category ?? this.category,
    );
  }
}

// Sample menu data based on the HTML template
final List<MenuItem> sampleMenuItems = [
  const MenuItem(
    id: '1',
    nameThai: 'ต้มยำกุ้ง',
    nameEnglish: 'Tom Yum Kung',
    description:
        'World-famous spicy and sour prawn soup with lemongrass, galangal, kaffir lime leaves, and mushrooms.',
    price: 180,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB7cwbzFDfbvd_Fv0YW2rzTaZkmNIFbnsf-LN45SudkvFsNG8fdXh5pFi8VPG-oS3pQ7zqdinhLuYi7xbYJSxrGoRvOShnvEB4tb_tMsZbcnPznQqeltjhjoJBmoIlvhuf4c46G3GJl2y9gVdaLAOqyzQK2ic790SD1tylGCfyv4qIbsKYUXn4Mj45JAw2PnTsbcDW92NUsIAkyN2U6prEmhUt_ROP_m23EaTAKhgOkNv1o3-WQeNw2kAhYfkRdYT7QWAyIRacTUWAY',
    spiceLevel: 3,
    badge: 'Best Seller',
    category: 'Main Dishes',
  ),
  const MenuItem(
    id: '2',
    nameThai: 'ผัดไทยกุ้งสด',
    nameEnglish: 'Pad Thai with Prawns',
    description:
        'Classic stir-fried rice noodles with egg, tofu, roasted peanuts, and fresh prawns in tamarind sauce.',
    price: 120,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDr3PxHA40hm6Xc5tjDJETSZ6w2PMBPDQt5Oh-NVIGL8Iy9FbzB_yQbmcjiNH2_EW-ssepMwR8U08WcNjXf2cIuBIRv4bCrd_91SNAzxn-1SFy-v9LPPmFkDqx1iaoGFaiztsMnZsqFrRd02xWqY6craKrxaxBv3Sv8ccHIqhA8kSV6nzHQW3q_y9OrUYLt1nll92J1SvbeNB_4rhhK1DmvHAQXnPCOGBWc-gr9pyd5eaIVpQGR05zwti7UoGbkxsT8HfoL-h3hb8kX',
    spiceLevel: 0,
    category: 'Main Dishes',
  ),
  const MenuItem(
    id: '3',
    nameThai: 'แกงเขียวหวานไก่',
    nameEnglish: 'Green Curry Chicken',
    description:
        'Aromatic sweet and spicy green curry with tender chicken breast, thai eggplant, and sweet basil.',
    price: 150,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDs_-2H7MvUUdJfPAtDVPLbipR2nlgvdtO42jvRwevfUtXpq32G50e1OBVu49oYo-V9wFxYG2JybsZlzkG7H91InciGIXGtQe_1vsqr4lNV_LVgLbd-Je-wSBmijKSY398wX_BMig2_2NHcoedNlFiN38gor4VNUyUhS4fG30FcPcnDN2f1TUe_f516Z_jbbye5DuXzEiSYdb6BxEPD3NIJj7-TjQfLI7R82848wJPoBLfDpckN9lgQYJQN6I0XGMlogJKzT0O1-ziH',
    spiceLevel: 2,
    category: 'Main Dishes',
  ),
  const MenuItem(
    id: '4',
    nameThai: 'ส้มตำไทย',
    nameEnglish: 'Som Tum Thai',
    description:
        'Fresh green papaya salad with peanuts, dried shrimp, long beans, tomatoes, lime, and chili.',
    price: 80,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAEQNhSGNuVS5sGEYMvzJJTgFw7mwevxO1nscD9-Bk1kNNCLAwgR1hy9X6vvWn_xOfzpfWSDyt6pP-4nDVSLJ87H42VY60IbphAvWCTjwftHagtL2oZYg1oU0S-GP3WMDGAbbpn942lVYUB_2kvONNLeMcRBCl8l2arFRcZLrcKDO4nzE1sG0FQ4JfJ-iwH7ytv1i1w6o8O9n3Zwq7h3fSvWFmP1uSXf0eBbnZfuoI3actQARNC2zZL0i1y51MMiLk1bWbWiUHOtAxF',
    spiceLevel: 2,
    category: 'Salads',
  ),
];

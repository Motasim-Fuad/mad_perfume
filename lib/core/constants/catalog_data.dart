class CollectionEntity {
  const CollectionEntity({
    required this.id,
    required this.nameKey,
    required this.imageUrl,
    required this.earnPoints,
    required this.heroLabel,
  });

  final String id;
  final String nameKey;
  final String imageUrl;
  final int earnPoints;
  final String heroLabel;
}

class ProductReview {
  const ProductReview({
    required this.author,
    required this.date,
    required this.rating,
    required this.body,
  });

  final String author;
  final String date;
  final int rating;
  final String body;
}

class ProductEntity {
  const ProductEntity({
    required this.id,
    required this.collectionId,
    required this.name,
    required this.price,
    required this.volume,
    required this.imageUrl,
    required this.description,
    required this.tags,
    required this.rating,
    required this.reviewCount,
    required this.availableAt,
    required this.reviews,
    this.featured = false,
  });

  final String id;
  final String collectionId;
  final String name;
  final double price;
  final String volume;
  final String imageUrl;
  final String description;
  final List<String> tags;
  final double rating;
  final int reviewCount;
  final String availableAt;
  final List<ProductReview> reviews;
  final bool featured;
}

class BranchEntity {
  const BranchEntity({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.hours,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.openUntil,
  });

  final String id;
  final String name;
  final String city;
  final String address;
  final String hours;
  final String phone;
  final String email;
  final String imageUrl;
  final String openUntil;
}

class RewardEntity {
  const RewardEntity({
    required this.id,
    required this.title,
    required this.points,
    required this.imageUrl,
    required this.subtitle,
    required this.description,
    required this.howToUse,
    required this.collectionId,
  });

  final String id;
  final String title;
  final int points;
  final String imageUrl;
  final String subtitle;
  final String description;
  final List<String> howToUse;
  final String collectionId;
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.time,
    this.imageUrl,
    this.tag,
  });

  final String id;
  final String category;
  final String title;
  final String body;
  final String time;
  final String? imageUrl;
  final String? tag;
}

class CatalogData {
  CatalogData._();

  static const usdPerPoint = 0.01;

  static const collections = <CollectionEntity>[
    CollectionEntity(
      id: 'floral',
      nameKey: 'floral',
      heroLabel: 'FLORAL',
      earnPoints: 80,
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    CollectionEntity(
      id: 'woody',
      nameKey: 'woody',
      heroLabel: 'WOODY',
      earnPoints: 110,
      imageUrl:
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    CollectionEntity(
      id: 'oriental',
      nameKey: 'oriental',
      heroLabel: 'ORIENTAL',
      earnPoints: 140,
      imageUrl:
          'https://images.unsplash.com/photo-1615634260167-c8cdede054de?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    CollectionEntity(
      id: 'fresh',
      nameKey: 'fresh_citrus',
      heroLabel: 'FRESH CITRUS',
      earnPoints: 60,
      imageUrl:
          'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    CollectionEntity(
      id: 'leather',
      nameKey: 'leather',
      heroLabel: 'LEATHER',
      earnPoints: 95,
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a49978fd?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    CollectionEntity(
      id: 'gourmand',
      nameKey: 'gourmand',
      heroLabel: 'GOURMAND',
      earnPoints: 70,
      imageUrl:
          'https://images.unsplash.com/photo-1481391319762-47dff72954d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
  ];

  static CollectionEntity collectionById(String id) {
    return collections.firstWhere((item) => item.id == id, orElse: () => collections.first);
  }

  static const products = <ProductEntity>[
    ProductEntity(
      id: 'velvet-oud',
      collectionId: 'oriental',
      name: 'Velvet Oud Edition',
      price: 355,
      volume: '100ML',
      featured: true,
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683601?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description:
          'A dialogue between shadows and light. Velvet Oud wraps warm woods in a golden, traditional resin of the East to reveal a crystalline, ethereal core.',
      tags: ['OUD NOIR', 'BERGAMOT', 'WHITE MUSK'],
      rating: 4.9,
      reviewCount: 112,
      availableAt: 'Place Vendome, Soho East',
      reviews: [
        ProductReview(
          author: 'Sophia B.',
          date: 'OCTOBER 14, 2023',
          rating: 5,
          body: 'An absolute masterpiece. The oud is subtle yet commanding. Perfect for evening wear.',
        ),
      ],
    ),
    ProductEntity(
      id: 'oud-minimaliste',
      collectionId: 'woody',
      name: 'Oud Minimaliste',
      price: 240,
      volume: '50ML',
      featured: true,
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description:
          'A dialogue between shadows and light. Oud Minimaliste strips away the heavy, traditional resins of the East to reveal a crystalline, ethereal core. It begins with the sharp, cold clarity of Bergamot, which melts into a heart of Oud, sustainably sourced from Laos that feels like a whisper rather than a shout.\n\nDesigned for the silent observer, this fragrance rests close to the skin, creating an invisible aura of presence. It is the olfactory embodiment of Invisible Elegance: sophisticated, structured, and profoundly understated.',
      tags: ['OUD NOIR', 'BERGAMOT', 'WHITE MUSK'],
      rating: 4.9,
      reviewCount: 112,
      availableAt: 'Place Vendome, Soho East',
      reviews: [
        ProductReview(
          author: 'Sophia B.',
          date: 'OCTOBER 14, 2023',
          rating: 5,
          body: 'An absolute masterpiece. The oud is subtle yet commanding. Perfect for evening wear.',
        ),
        ProductReview(
          author: 'James L.',
          date: 'SEPTEMBER 02, 2023',
          rating: 5,
          body: 'The definition of invisible elegance. It does not scream for attention, but everyone notices when you enter the room.',
        ),
      ],
    ),
    ProductEntity(
      id: 'noir-absolute',
      collectionId: 'leather',
      name: 'Noir Absolute',
      price: 280,
      volume: '50ML / 1.7 OZ EDP',
      featured: true,
      imageUrl:
          'https://images.pexels.com/photos/3059609/pexels-photo-3059609.jpeg?auto=compress&cs=tinysrgb&w=1400',
      description:
          'Midnight woods pressed into smoked leather. A signature for those who collect silence as much as scent.',
      tags: ['LEATHER', 'SMOKE', 'AMBER'],
      rating: 4.8,
      reviewCount: 86,
      availableAt: 'Mayfair Atelier',
      reviews: [
        ProductReview(
          author: 'Elena V.',
          date: 'NOVEMBER 02, 2023',
          rating: 5,
          body: 'Dark, polished, and impossibly smooth on skin.',
        ),
      ],
    ),
    ProductEntity(
      id: 'santa-rosa',
      collectionId: 'floral',
      name: 'Santa Rosa',
      price: 190,
      volume: '50ML / 1.7 OZ EDP',
      imageUrl:
          'https://images.unsplash.com/photo-1615634260167-c8cdede054de?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'A dewy rose garden at dawn, lifted by pale musk and a drop of green pear.',
      tags: ['ROSE', 'MUSK', 'PEAR'],
      rating: 4.7,
      reviewCount: 64,
      availableAt: 'Le Marais',
      reviews: [
        ProductReview(
          author: 'Camille R.',
          date: 'AUGUST 21, 2023',
          rating: 5,
          body: 'Soft, luminous, and stays close like a secret.',
        ),
      ],
    ),
    ProductEntity(
      id: 'desert-smoke',
      collectionId: 'oriental',
      name: 'Desert Smoke',
      price: 310,
      volume: '50ML / 1.7 OZ EDP',
      imageUrl:
          'https://images.unsplash.com/photo-1587017539504-67cfbddac569?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'Incense, saffron and sun-warmed resin drifting over cool night sand.',
      tags: ['INCENSE', 'SAFFRON', 'SANDALWOOD'],
      rating: 4.9,
      reviewCount: 91,
      availableAt: 'Ginza Flagship',
      reviews: [
        ProductReview(
          author: 'Omar K.',
          date: 'JULY 11, 2023',
          rating: 5,
          body: 'A pilgrimage in a bottle. Unforgettable dry-down.',
        ),
      ],
    ),
    ProductEntity(
      id: 'avant-mini',
      collectionId: 'fresh',
      name: 'Avant Mini',
      price: 95,
      volume: '15ML / 0.5 OZ EDP',
      imageUrl:
          'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'A bright citrus spark designed for travel, layered over clean white tea.',
      tags: ['CITRUS', 'TEA', 'AMBROX'],
      rating: 4.6,
      reviewCount: 40,
      availableAt: 'Soho Atelier',
      reviews: [
        ProductReview(
          author: 'Noah P.',
          date: 'MAY 04, 2023',
          rating: 4,
          body: 'Perfect day scent. Compact and generous.',
        ),
      ],
    ),
    ProductEntity(
      id: 'midnight-noir',
      collectionId: 'woody',
      name: 'Midnight Noir',
      price: 355,
      volume: '100ML / 3.4 OZ EDP',
      featured: true,
      imageUrl:
          'https://images.pexels.com/photos/965989/pexels-photo-965989.jpeg?auto=compress&cs=tinysrgb&w=1400',
      description: 'Black cedar and vetiver under a veil of cool iris. Night architecture in scent.',
      tags: ['CEDAR', 'IRIS', 'VETIVER'],
      rating: 4.8,
      reviewCount: 73,
      availableAt: 'Place Vendome',
      reviews: [
        ProductReview(
          author: 'Iris M.',
          date: 'DECEMBER 01, 2023',
          rating: 5,
          body: 'Sculptural and quiet. My signature now.',
        ),
      ],
    ),
    ProductEntity(
      id: 'golden-bloom',
      collectionId: 'floral',
      name: 'Golden Bloom',
      price: 210,
      volume: '100ML / 3.4 OZ EDP',
      featured: true,
      imageUrl:
          'https://images.pexels.com/photos/1961795/pexels-photo-1961795.jpeg?auto=compress&cs=tinysrgb&w=1400',
      description: 'Neroli honeyed by sunlight, blooming into warm jasmine absolute.',
      tags: ['NEROLI', 'JASMINE', 'HONEY'],
      rating: 4.7,
      reviewCount: 58,
      availableAt: 'Mayfair District',
      reviews: [
        ProductReview(
          author: 'Lina S.',
          date: 'JUNE 18, 2023',
          rating: 5,
          body: 'Golden hour in a bottle.',
        ),
      ],
    ),
    ProductEntity(
      id: 'oud-immortal',
      collectionId: 'oriental',
      name: 'Oud Immortal',
      price: 210,
      volume: '100ML / EAU DE PARFUM',
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?ixlib=rb-4.0.3&auto=format&fit=crop&w=900&q=80',
      description: 'A private collection oud, dense yet airy, built for slow evenings.',
      tags: ['OUD', 'ROSE', 'AMBER'],
      rating: 4.9,
      reviewCount: 44,
      availableAt: 'Champs-Elysees',
      reviews: [
        ProductReview(
          author: 'Adrian F.',
          date: 'MARCH 09, 2023',
          rating: 5,
          body: 'Rich without heaviness. Exceptional.',
        ),
      ],
    ),
    ProductEntity(
      id: 'bergamot-tea',
      collectionId: 'fresh',
      name: 'Bergamot & Tea',
      price: 170,
      volume: '50ML / ESSENTIAL',
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-363ea4662cda?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'Pressed bergamot over steamed white tea and a cool mineral musk.',
      tags: ['BERGAMOT', 'TEA', 'MUSK'],
      rating: 4.5,
      reviewCount: 33,
      availableAt: 'Via Montenapoleone',
      reviews: [
        ProductReview(
          author: 'Jules A.',
          date: 'APRIL 12, 2023',
          rating: 4,
          body: 'Clean, expensive, endlessly wearable.',
        ),
      ],
    ),
    ProductEntity(
      id: 'night-jasmine',
      collectionId: 'floral',
      name: 'Night Jasmine',
      price: 45,
      volume: '30ML / ESSENTIAL',
      imageUrl:
          'https://images.unsplash.com/photo-1615634260167-c8cdede054de?ixlib=rb-4.0.3&auto=format&fit=crop&w=900&q=80',
      description: 'A concentrated jasmine soliflore for layering after dusk.',
      tags: ['JASMINE', 'INDOLE', 'SANDAL'],
      rating: 4.4,
      reviewCount: 21,
      availableAt: 'Le Marais',
      reviews: [
        ProductReview(
          author: 'Mira T.',
          date: 'FEBRUARY 02, 2023',
          rating: 4,
          body: 'Night-blooming and intimate.',
        ),
      ],
    ),
    ProductEntity(
      id: 'nocturnal-bloom',
      collectionId: 'gourmand',
      name: 'Nocturnal Bloom',
      price: 95,
      volume: 'SCENTED CANDLE / 300G',
      imageUrl:
          'https://images.unsplash.com/photo-1603006905003-be475563bc59?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'A candle of tuberose, tonka and warm waxed woods for the atelier at home.',
      tags: ['TUBEROSE', 'TONKA', 'WOOD'],
      rating: 4.6,
      reviewCount: 19,
      availableAt: 'Soho Atelier',
      reviews: [
        ProductReview(
          author: 'Claire D.',
          date: 'JANUARY 20, 2023',
          rating: 5,
          body: 'The room smells like a Paris suite.',
        ),
      ],
    ),
  ];

  static ProductEntity productById(String id) {
    return products.firstWhere((item) => item.id == id, orElse: () => products.first);
  }

  static List<ProductEntity> byCollection(String id) {
    return products.where((item) => item.collectionId == id).toList();
  }

  static List<ProductEntity> featured() {
    return products.where((item) => item.featured).toList();
  }

  static const branches = <BranchEntity>[
    BranchEntity(
      id: 'mayfair',
      name: 'Mayfair Atelier',
      city: 'London',
      address: '12 Grosvenor Street, Mayfair\nW1K 3SL, London',
      hours: 'Mon - Sat 10:00 - 19:00\nSunday 12:00 - 18:00',
      phone: '+44 20 7946 0958',
      email: 'mayfair@madperfume.com',
      openUntil: '20:00 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    BranchEntity(
      id: 'marais',
      name: 'Le Marais',
      city: 'Paris',
      address: '28 Rue des Francs Bourgeois\n75003 Paris',
      hours: 'Mon - Sat 11:00 - 20:00\nSunday 12:00 - 18:00',
      phone: '+33 1 42 77 00 11',
      email: 'marais@madperfume.com',
      openUntil: '19:00 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    BranchEntity(
      id: 'ginza',
      name: 'Ginza Flagship',
      city: 'Tokyo',
      address: '5-8-1 Ginza, Chuo-ku\n104-0061 Tokyo',
      hours: 'Daily 11:00 - 20:00',
      phone: '+81 3 3571 1111',
      email: 'ginza@madperfume.com',
      openUntil: '21:00 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    BranchEntity(
      id: 'montenapoleone',
      name: 'Via Montenapoleone',
      city: 'Milan',
      address: 'Via Monte Napoleone, 17\n20121 Milano',
      hours: 'Mon - Sat 10:00 - 19:30',
      phone: '+39 02 7600 1122',
      email: 'milan@madperfume.com',
      openUntil: '19:30 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    BranchEntity(
      id: 'soho',
      name: 'Soho Atelier',
      city: 'New York',
      address: '120 Wooster Street\nNew York, NY 10012',
      hours: 'Mon - Sat 11:00 - 20:00\nSunday 12:00 - 18:00',
      phone: '+1 212 555 0199',
      email: 'soho@madperfume.com',
      openUntil: '20:00 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1485871981521-5b1fd3805eee?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
    BranchEntity(
      id: 'champs',
      name: 'Champs-Elysees',
      city: 'Paris',
      address: '68 Avenue des Champs-Elysees\n75008 Paris, France',
      hours: 'Mon - Sat 10:00 - 20:00\nSunday 12:00 - 19:00',
      phone: '+33 1 43 12 90 00',
      email: 'champselysees@madperfume.com',
      openUntil: '20:00 PM',
      imageUrl:
          'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
    ),
  ];

  static BranchEntity branchById(String id) {
    return branches.firstWhere((item) => item.id == id, orElse: () => branches.first);
  }

  static const rewards = <RewardEntity>[
    RewardEntity(
      id: 'private-oud',
      title: 'Private Reserve: Oud & Santal',
      points: 5000,
      collectionId: 'oriental',
      subtitle: 'ACCESS TO THE RESERVE',
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683601?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description:
          'Access our most exclusive vintage, aged for three years in sustainable oak casks. A singular scent for true connoisseurs.',
      howToUse: [
        'Visit any MAD boutique',
        'Present your digital voucher',
        'Collect your exclusive scent',
      ],
    ),
    RewardEntity(
      id: 'discovery-set',
      title: 'Discovery Set: Signature Series',
      points: 1200,
      collectionId: 'floral',
      subtitle: 'CURATED SAMPLING',
      imageUrl:
          'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'A curated voyage of niche fragrances, housed in a lacquered atelier case.',
      howToUse: [
        'Redeem in the app',
        'We ship to your atelier address',
        'Layer, journal, return for a full bottle credit',
      ],
    ),
    RewardEntity(
      id: 'gift-wrap',
      title: 'Bespoke Gift Wrapping',
      points: 450,
      collectionId: 'gourmand',
      subtitle: 'ATELIER FINISHING',
      imageUrl:
          'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'Hand-finished silk ribbon and wax seal, reserved for three pieces in your next dispatch.',
      howToUse: [
        'Apply at checkout on your next order',
        'Our atelier completes the wrap',
        'Delivered as a sealed gift',
      ],
    ),
    RewardEntity(
      id: 'scented-04',
      title: 'Scented Candle No. 04',
      points: 850,
      collectionId: 'gourmand',
      subtitle: 'HOME RITUAL',
      imageUrl:
          'https://images.unsplash.com/photo-1603006905003-be475563bc59?ixlib=rb-4.0.3&auto=format&fit=crop&w=1400&q=80',
      description: 'A 300g candle of nocturnal bloom with bergamot and white tea.',
      howToUse: [
        'Redeem and collect in boutique or delivery',
        'Burn no longer than three hours',
        'Trim the wick between sessions',
      ],
    ),
  ];

  static RewardEntity rewardById(String id) {
    return rewards.firstWhere((item) => item.id == id, orElse: () => rewards.first);
  }

  static const notifications = <AppNotification>[
    AppNotification(
      id: 'n1',
      category: 'offers',
      title: 'Private Sale: The Midnight Oud Collection',
      body: 'Exclusive 20%',
      time: '24 HOURS AGO',
      tag: 'LIMITED EDITION',
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
    ),
    AppNotification(
      id: 'n2',
      category: 'reward',
      title: 'Platinum Status Achievement',
      body:
          "You've reached our highest tier. Complimentary 50ml fragrance of your choice awaits.",
      time: '2 DAYS AGO',
    ),
    AppNotification(
      id: 'n3',
      category: 'order',
      title: 'Your signature scent is in transit',
      body: 'Shipment is currently in Paris. Expected delivery: Oct 24th.',
      time: '2 DAYS AGO',
      tag: 'ORDER #MD-9321',
    ),
    AppNotification(
      id: 'n4',
      category: 'order',
      title: 'Order Delivered',
      body: 'Fragrance Discovery Set has been delivered to your concierge.',
      time: 'OCT 10',
    ),
  ];
}

class Artwork {
  final String id;
  final String title;
  final String description;
  final List<String> images; // Multiple images support
  final String? category; // Optional now
  final DateTime createdAt;
  final List<String> tags;

  Artwork({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    this.category,
    DateTime? createdAt,
    this.tags = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  // Sample data - perfect for face sketches portfolio
  static List<Artwork> getSampleArtworks() {
    return [
      Artwork(
        id: '1',
        title: 'Intensity',
        description:
            'A powerful portrait study capturing raw emotion and strength through meticulous graphite rendering, exploring the depths of human expression.',
        images: ['assets/images/sketch1.jpeg'],
        tags: [
          'portrait',
          'expressive',
          'graphite',
          'contemporary',
          'male study',
        ],
      ),
      Artwork(
        id: '2',
        title: 'Eternal Bond',
        description:
            'A Mother\'s Day tribute celebrating the unbreakable connection between mother and child. Every delicate line honors the infinite love that shapes us.',
        images: [
          'assets/images/sketch2.jpg',
          'assets/images/sketch2_alt1.jpeg',
        ],
        tags: [
          'motherhood',
          'special occasion',
          'emotional',
          'tribute',
          'family love',
        ],
      ),
      Artwork(
        id: '3',
        title: 'Hands That Hold Us',
        description:
            'Created for Mother\'s Day, this intimate study celebrates the gentle strength of maternal touch—the hands that comfort, guide, and never let go.',
        images: ['assets/images/sketch3.jpg'],
        tags: [
          'mothers day',
          'symbolism',
          'hands study',
          'emotional depth',
          'meaningful',
        ],
      ),
      Artwork(
        id: '4',
        title: 'Divine Grace',
        description:
            'A devotional portrait of Shirdi Sai Baba, rendered with reverence and precision. The blessing gesture embodies compassion and spiritual wisdom.',
        images: ['assets/images/sketch4.jpeg'],
        tags: [
          'spiritual art',
          'devotional',
          'sai baba',
          'traditional',
          'sacred',
        ],
      ),
      Artwork(
        id: '5',
        title: 'Sweta - Elegance Captured',
        description:
            'A portrait celebrating Sweta\'s grace in traditional attire. The detailed rendering showcases the harmony between photographic reference and artistic interpretation.',
        images: ['assets/images/sketch5.jpg'],
        tags: [
          'friendship',
          'traditional beauty',
          'realistic portrait',
          'female portrait',
          'cultural',
        ],
      ),
      Artwork(
        id: '6',
        title: 'Suraj Padale - Modern Perspectives',
        description:
            'A contemporary portrait of a dear friend, capturing Suraj\'s distinctive style and personality through careful attention to modern aesthetics and character.',
        images: ['assets/images/sketch6.jpeg'],
        tags: [
          'friendship portrait',
          'contemporary',
          'personal connection',
          'modern style',
          'realistic',
        ],
      ),
      Artwork(
        id: '7',
        title: 'First Birthday Blessing',
        description:
            'A special gift marking a milestone—created for my college friend\'s niece on her first birthday. This portrait immortalizes the joy of childhood and new beginnings.',
        images: ['assets/images/sketch7.jpg', 'assets/images/sketch7_alt1.jpg'],
        tags: [
          'birthday gift',
          'milestone',
          'baby portrait',
          'celebration',
          'commissioned work',
        ],
      ),
      Artwork(
        id: '8',
        title: 'Krishnan Kumar - Leadership Portrait',
        description:
            'A professional tribute to Krishnan Kumar, CEO of Invenics. This detailed portrait was gifted as a token of respect and appreciation for inspiring leadership.',
        images: [
          'assets/images/sketch8.jpeg',
          'assets/images/sketch8_alt1.jpeg',
        ],
        tags: [
          'professional gift',
          'ceo portrait',
          'gratitude',
          'corporate art',
          'commissioned',
        ],
      ),
      Artwork(
        id: '9',
        title: 'Holiday Cheer',
        description:
            'A festive Santa Claus artwork created during office Christmas celebrations. Brought to life with vibrant colors to add warmth and joy to our workplace decorations.',
        images: [
          'assets/images/sketch9.jpeg',
          'assets/images/sketch9_alt1.jpeg',
        ],
        tags: [
          'christmas',
          'festive art',
          'office celebration',
          'seasonal',
          'holiday decor',
          'colored artwork',
        ],
      ),
      Artwork(
        id: '10',
        title: 'Together at Golden Hour',
        description:
            'My first venture into painting—a romantic canvas capturing two souls silhouetted against nature\'s most beautiful moment. The golden sunset symbolizes warmth, hope, and togetherness.',
        images: [
          'assets/images/sketch10.jpeg',
          'assets/images/sketch10_alt1.jpeg',
        ],
        tags: [
          'first painting',
          'acrylic art',
          'romance',
          'sunset',
          'landscape',
          'milestone work',
        ],
      ),
    ];
  }
}

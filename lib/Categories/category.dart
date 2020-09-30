class Category {
  Category({
    this.title = '',
    this.imagePath = '',
  });

  String title;
  String imagePath;

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/Books.png',
      title: 'Books',
    ),
    Category(
      imagePath: 'assets/artncraft.jpg',
      title: 'Art and Craft',
    ),
    Category(
      imagePath: 'assets/SportsandGames.jpg',
      title: 'Sports and Games',
    ),
    Category(
      imagePath: 'assets/music.png',
      title: 'Music',
    ),
    Category(
      imagePath: 'assets/tools.jpg',
      title: 'Tools',
    ),
    Category(
      imagePath: 'assets/machines.jpg',
      title: 'Machines',
    ),
  ];

}

class FavoriteRestaurant {
  final String id;
  final String name;
  final String city;
  final String region;
  final String imageUrl;
  final dynamic rating;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.imageUrl,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'region': region,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }

  factory FavoriteRestaurant.fromMap(Map<String, dynamic> map) {
    return FavoriteRestaurant(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      region: map['region'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
    );
  }
}
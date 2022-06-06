// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Encode and store data in SharedPreferences
  final String encodedData = Music.encode([]);

  await prefs.setString('musics_key', encodedData);

  // Fetch and decode data
  final String? musicsString = prefs.getString('musics_key');

  final List<Music> musics = Music.decode(musicsString!);
}

class Music {
  final int id;
  final String name, size, rating, duration, img;
  bool favorite;

  Music({
    required this.id,
    required this.rating,
    required this.size,
    required this.duration,
    required this.name,
    required this.img,
    required this.favorite,
  });

  factory Music.fromJson(Map<String, dynamic> jsonData) {
    return Music(
      id: jsonData['id'],
      rating: jsonData['rating'],
      size: jsonData['size'],
      duration: jsonData['duration'],
      name: jsonData['name'],
      img: jsonData['img'],
      favorite: false,
    );
  }

  static Map<String, dynamic> toMap(Music music) => {
        'id': music.id,
        'rating': music.rating,
        'size': music.size,
        'duration': music.duration,
        'name': music.name,
        'img': music.img,
        'favorite': music.favorite,
      };

  static String encode(List<Music> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => Music.toMap(music))
            .toList(),
      );

  static List<Music> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Music>((item) => Music.fromJson(item))
          .toList();
}

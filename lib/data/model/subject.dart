import 'package:flutter/widgets.dart';

class Subject {
  final int id;
  final String slug;
  final String name;
  final String desc;
  final String lecturer;
  final String image;
  final List<Color> gradient;
  final int totalStudent;

  Subject({
    required this.id,
    required this.slug,
    required this.name,
    required this.desc,
    required this.lecturer,
    required this.image,
    required this.gradient,
    required this.totalStudent,
  });
}
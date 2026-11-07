import 'package:flutter/widgets.dart';

enum ProfileType { personal, business, freelancer, merchant }

@immutable
class FinsightProfile {
  const FinsightProfile({
    required this.type,
    required this.title,
    required this.tagline,
    required this.description,
    required this.icon,
    required this.highlights,
  });

  final ProfileType type;
  final String title;
  final String tagline;
  final String description;
  final IconData icon;
  final List<String> highlights;

  String get routePath => '/dashboard/${type.name}';
}

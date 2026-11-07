import 'package:flutter/widgets.dart';

import '../../app/routes.dart';

enum ProfileType {
  personal,
  business,
  freelancer,
  merchant;

  /// Returns the profile whose name equals [value], or null when unknown.
  /// Matching is case-sensitive.
  static ProfileType? tryParse(String? value) => values.asNameMap()[value];
}

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

  /// Bare profile route. The router redirects it to the Home tab.
  String get routePath => AppRoutes.profileDashboard(type.name);
}

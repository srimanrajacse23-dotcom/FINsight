import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/finsight_profile.dart';

/// Holds the profile the user picked. `null` means nothing selected yet.
class SelectedProfileNotifier extends Notifier<ProfileType?> {
  @override
  ProfileType? build() => null;

  void select(ProfileType type) => state = type;

  void clear() => state = null;
}

final selectedProfileProvider =
    NotifierProvider<SelectedProfileNotifier, ProfileType?>(
      SelectedProfileNotifier.new,
    );

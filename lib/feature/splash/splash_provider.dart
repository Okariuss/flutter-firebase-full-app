// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_full_app/product/enums/platform_enums.dart';
import 'package:flutter_firebase_full_app/product/models/number_model.dart';
import 'package:flutter_firebase_full_app/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase_full_app/product/utility/version_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkApplicationVersion(String clientVersion) async {
    final databaseValue = await getVersionNumberFromDatabase();

    if (databaseValue == null || databaseValue.isEmpty) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }

    final checkIsNeedForceUpdate = VersionManager(
        deviceValue: clientVersion, databaseValue: databaseValue);

    if (checkIsNeedForceUpdate.isNeedUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    final response = await FirebaseCollections.version.reference
        .withConverter<NumberModel>(
          fromFirestore: (snapshot, options) {
            return NumberModel().fromFirebase(snapshot);
          },
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(PlatformEnums.versionName)
        .get();
    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  SplashState({this.isRequiredForceUpdate, this.isRedirectHome});

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];

  SplashState copyWith({
    bool? isRequiredForceUpdate,
    bool? isRedirectHome,
  }) {
    return SplashState(
      isRequiredForceUpdate:
          isRequiredForceUpdate ?? this.isRequiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }
}

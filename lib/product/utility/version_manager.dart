import 'exceptions/version_custom_exception.dart';

class VersionManager {
  final String deviceValue;
  final String databaseValue;

  VersionManager({required this.deviceValue, required this.databaseValue});

  bool isNeedUpdate() {
    final deviceNumberSplit = deviceValue.split('.').join();
    final databaseNumberSplit = databaseValue.split('.').join();

    final deviceNumber = int.tryParse(deviceNumberSplit);
    final databaseNumber = int.tryParse(databaseNumberSplit);

    if (deviceNumber == null || databaseNumber == null) {
      throw VersionCustomException(
        '$deviceValue or $databaseValue is not valid for parse.',
      );
    }

    return deviceNumber < databaseNumber;
  }
}

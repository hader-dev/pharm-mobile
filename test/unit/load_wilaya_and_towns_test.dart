import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/actions/load_wilaya_towns.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/actions/load_wilayas.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilaya_towns_params.dart';
import 'package:hader_pharm_mobile/repositories/locale/wilaya/params/load_wilayas_params.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String locale;

  Future<String> loadJsonFileString(String path) async {
    return File(path).readAsString();
  }

  setUp(() {
    locale = 'en';
  });

  group('WilayaRepositoryImpl', () {
    test('getWilayas returns a valid ResponseLoadWilayas', () async {
      final result = await loadWilayas(ParamsLoadWilayas(
          locale: locale, jsonStringLoader: loadJsonFileString));

      expect(result.wilayas.length, greaterThan(0));
      expect(result.wilayas.first.label, equals('Adrar'));
    });

    test('getWilayaTowns returns a valid ResponseLoadWilayaTowns', () async {
      final result = await loadWilayaTowns(
        ParamsLoadWilayaTowns(
            locale: locale, wilayaId: 1, jsonStringLoader: loadJsonFileString),
      );
      expect(result.towns.length, greaterThan(0));
      expect(result.towns.first.label, equals('Adrar'));
    });
  });
}

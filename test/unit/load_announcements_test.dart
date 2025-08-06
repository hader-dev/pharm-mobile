import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/mappers/json_to_announcement.dart';
import 'package:path/path.dart' as p;

void main() {

// C:\Projects\hader-pharm-mobile\test
  Future<String> loadJsonFileString(String relativePathFromProjectRoot) async {
  final baseDir = Directory.current.path;

  final filePath = p.join(baseDir, relativePathFromProjectRoot);
  final file = File(filePath);

  if (!file.existsSync()) {
    throw Exception('File not found: $filePath');
  }

  return file.readAsString();
}


  group('AnnouncementRepositoryImpl', () {
    test('getAnnouncements returns a valid ResponseLoadAnnouncements', () async {

      final data = await loadJsonFileString("test/resources/get_announcements.json");
      final parsed = jsonDecode(data);
      

      final result = jsonToAnnouncementsList(parsed);

      expect(result.length, greaterThan(0));
      expect(result.first.title, equals('Test Ann'));
    });

  });
}

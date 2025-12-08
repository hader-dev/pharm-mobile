import 'dart:io';
import 'package:minio/minio.dart';

Future<void> main(List<String> args) async {
  /** prams got from command line
   * minio-s3.hader.online
   * mobile
   * hader
   * Hader@123
   * 
   */

  final endpoint = args[0];
  final bucket = args[1];
  final accessKey = args[2];
  final secretKey = args[3];
  final appFlavor = args[4];
  final filePath = "build/app/outputs/apk/$appFlavor/release/app-$appFlavor-release.apk";

  final file = File(filePath);

  if (!file.existsSync()) {
    print('File does not exist: $filePath');
    exit(1);
  }

  final minio = Minio(
    endPoint: endpoint,
    accessKey: accessKey,
    secretKey: secretKey,
    useSSL: true,
  );

  final objectName = file.uri.pathSegments.last;

  print('Uploading $objectName to $bucket ...');

  if (!await minio.bucketExists(bucket)) minio.makeBucket(bucket);
  await minio.putObject(bucket, objectName, file.readAsBytes().asStream());

  print('Upload successful!');
}

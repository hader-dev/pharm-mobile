import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchEmail({
  required String toEmail,
  String subject = '',
  String body = '',
  List<String> cc = const [],
  List<String> bcc = const [],
}) async {
  try {
    final Map<String, String> queryParams = {};

    if (subject.isNotEmpty) {
      queryParams['subject'] = subject;
    }

    if (body.isNotEmpty) {
      queryParams['body'] = body;
    }

    if (cc.isNotEmpty) {
      queryParams['cc'] = cc.join(',');
    }

    if (bcc.isNotEmpty) {
      queryParams['bcc'] = bcc.join(',');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    bool launched = await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      launched = await launchUrl(
        emailUri,
        mode: LaunchMode.platformDefault,
      );

      if (!launched) {
        throw Exception('No email client available or launch failed');
      }
    }
  } on PlatformException catch (e) {
    throw Exception('Platform error: ${e.message}');
  } catch (e) {
    throw Exception('Failed to launch email client: $e');
  }
}

Future<void> launchPhoneCall(String phoneNumber) async {
  final Uri telUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(telUri)) {
    await launchUrl(telUri);
  } else {
    throw Exception('Could not launch phone dialer');
  }
}

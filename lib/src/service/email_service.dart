import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static void sendEmail(String emailAddress, String subject, String body) async {
    String url = "mailto:$emailAddress?subject=$subject&body=$body";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

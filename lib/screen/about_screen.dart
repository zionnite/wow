import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String about_us_link = 'https://osherwomen.com/About';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        // title: Text(
        //   'About W.0.W',
        //   style: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Osher Women (W.O.W) are in partnership with Greatway foundation registered in 2009 is the Edinburgh branch of the African Forum Scotland company founded in 2007 and have operated successfully. Thereby it has received an endorsement by United Nations Conference for Trade and Development – UNCTAD. Thereafter, it was endorsed by the First Minister Scotland – Nicola Sturgeon for its achievement in bringing trade from Scotland to Africa and vice versa. Since then, we have grown to become market leaders and a front runner in the future development of Africa.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Partners',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'wow App is Developed by Osher Women, in Partnership with Comic Relief, Greatway Foundation & Next Step Initiative',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/osher_women.jpg'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/great_way.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/next_step.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/comic_relief.png',
                fit: BoxFit.fitWidth,
              ),
            ),

            /*==Bottom===*/
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: GestureDetector(
                onTap: () {
                  _launchUniversalLinkIos(about_us_link);
                },
                child: Card(
                  color: Colors.redAccent,
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, bottom: 18.0, left: 20.0, right: 20.0),
                    child: Text(
                      'Click here to read More',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _onOpen(LinkableElement link) async {
  if (await canLaunch(link.url)) {
    await launch(link.url);
  } else {
    throw 'Could not launch $link';
  }
}

Future<void> _launchUniversalLinkIos(String url) async {
  if (await canLaunch(url)) {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  }
}

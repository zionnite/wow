import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wow/utils.dart';

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
        backgroundColor: secondColor,
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
                'This application was pioneered by Greatway Foundation, in Partnership with Comic Relief, Next Step Initiative & Community Fund',
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
            // Row(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Image.asset(
            //           'assets/images/great_way.png',
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Image.asset(
            //           'assets/images/next_step.png',
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/great_way.png',
                fit: BoxFit.cover,
                width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/next_step.png',
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/comic_relief.png',
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 40,
                right: 40,
                bottom: 20,
              ),
              child: Image.asset(
                'assets/images/com.jpeg',
                fit: BoxFit.cover,
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

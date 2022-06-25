import 'package:flutter/material.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        title: Text(
          "About Us",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width / 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(children: [
          Stack(
            children: <Widget>[
              Container(
                color: mainColor,
                height: 100,
              ),
              Container(
                  height: 1000,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 0.0),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 9,
                        child: Text(
                          ''' Self love app is a free daily motivational and inspiring app, which sends you daily inspiring messages to help brighten your day. The app is created with the intention to increase positively around the world. 

Why you should install Self love app:-

*It's free

*You will get daily inspiring messages everyday to light up your day.(Always Click on the daily notification alert to esure that the next day quote will show)


*Have free access to our 100 self love quotes for an extra boost of motivation 

Our goal is to inspire you everyday to love yourself and be proud of yourself. To cheer you up in your darkest times. Through the self love app, we are able to send you inspiring messages to guide you through your daily life. Our dream is to make the world a better place!. 


We would love to make the app better, easier and more convenient to use. If you have any suggestions on how we can make self love app a better app, we will be happy to hear from you. 

Keep in touch with us via
Email: theselfloveapp@gmail.com

''',
                          style: TextStyle(),
                        )),
                  )),
            ],
          ),

          // Container(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: MediaQuery.of(context).size.width / 10),
          //     margin: EdgeInsets.only(
          //         top: MediaQuery.of(context).size.height / 1),
          //     child: InkWell(
          //       child: SelectableText(
          //         "Instagram: https://www.instagram.com/selfloveapp?r=nametag",
          //         style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.blueAccent),
          //         onTap: () async {
          //           var url =
          //               " https://www.instagram.com/selfloveapp?r=nametag";
          //           if (await canLaunch(url)) {
          //             await launch(
          //               url,
          //               forceSafariVC: false,
          //               forceWebView: false,
          //               headers: <String, String>{
          //                 'my_header_key': 'my_header_value'
          //               },
          //             );
          //           } else {
          //             throw 'Could not launch $url';
          //           }
          //         },
          //       ),
          //     ),
          //   )
        ])),
      ),
    );
  }
}

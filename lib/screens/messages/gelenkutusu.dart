import 'package:ezka_interview/screens/messages/mesajgonder.dart';
import 'package:ezka_interview/size_config.dart';
import 'package:flutter/material.dart';

class Gelenkutusu extends StatefulWidget {
  const Gelenkutusu({Key? key}) : super(key: key);

  @override
  State<Gelenkutusu> createState() => _GelenkutusuState();
}

class _GelenkutusuState extends State<Gelenkutusu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Gelenkutusu1(),
    );
  }
}

class mesaj {
  String? ad;

  String? cikisyeri;
  String? varisyeri;

  String? photo;
  String? cikissaat;
  String? varissaat;
  String? varistarih;
  String? bagajalan;
  String? kalanbagajalan;
  String? uk;
  String? ok;
  String? bk;
  String? zarf;
  mesaj({
    this.ad,
    this.cikisyeri,
    this.uk,
    this.ok,
    this.bk,
    this.zarf,
    this.varisyeri,
    this.photo,
    this.cikissaat,
    this.varissaat,
    this.varistarih,
  });
}

class Gelenkutusu1 extends StatefulWidget {
  const Gelenkutusu1({Key? key}) : super(key: key);

  @override
  State<Gelenkutusu1> createState() => _Gelenkutusu1State();
}

class _Gelenkutusu1State extends State<Gelenkutusu1> {
  List<mesaj> veriler = [
    mesaj(
      ad: "Alp Karadeniz",
      photo: "assets/images/profile.png",
      cikissaat: "20:00",
      varissaat: "00:00",
      cikisyeri: "Muğla/Merkez",
      varisyeri: "Balıkesir/Altıeylül",
      varistarih: "22/04/2022",
    )
  ];
  // int deger = 1;
  // Widget? body;
  // @override
  // void initState() {
  //   super.initState();
  //   body = Tasidiklarim();
  // }

  Widget Tasidiklarim() {
    return Column(
      children: [
        ListView.separated(
          // physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          itemCount: 3, //!
          // itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Mesajgonder1()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.9,
                    height: SizeConfig.screenHeight * 0.12,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffb707070), width: 2),
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: SizeConfig.screenWidth * 0.09,
                              backgroundImage: const Image(
                                      image:
                                          AssetImage("assets/icons/user.png"))
                                  .image,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Alp K.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenWidth * 0.038,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "22/05/2022",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenWidth * 0.038,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: SizeConfig.screenHeight * 0.03,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // const ArkaPlan(),
        SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                const Image(image: AssetImage("assets/images/logo.png")),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: SizeConfig.screenWidth * 0.55),
                  child: const Text(
                    "Gelen Kutusu",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Divider(
                    thickness: SizeConfig.screenHeight * 0.004,
                    color: Colors.white,
                  ),
                ),
                Tasidiklarim(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

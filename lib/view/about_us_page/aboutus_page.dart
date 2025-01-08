import 'package:flutter/material.dart';
import 'package:gomart_wahy/dummy_db.dart';
import 'package:gomart_wahy/view/floatingactionbutton/custom_floatingbutton.dart';
import 'package:gomart_wahy/view/homescreen/drawerscreen/drawer_screen.dart';
import 'package:gomart_wahy/view/homescreen/home_screen.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_greencard.dart';
import 'package:gomart_wahy/view/homescreen/widget/header_whitebox.dart';
import 'package:gomart_wahy/view/homescreen/widget/homepage.dart';
import 'package:gomart_wahy/view/homescreen/widget/shop_and_about_button.dart';

class AboutusPage extends StatefulWidget {
  const AboutusPage({super.key});

  @override
  State<AboutusPage> createState() => _AboutusPageState();
}

class _AboutusPageState extends State<AboutusPage> {
  final ScrollController _scrollController = ScrollController();
  void scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 320, // Scroll by 320px (card width + spacing)
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 320, // Scroll by 320px (card width + spacing)
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  final List<Map<String, dynamic>> testimonials = [
    {
      "name": "George Nakashima",
      "image": "assets/png/client-2.png",
      "review":
          "Conveniently synergize premium collaboration and idea-sharing with compelling \"outside the box\" thinking. Interactive product distinctive paradigms whereas one-to-one intellectual capital. resource sucking services. Objectively customize vertical.",
    },
    {
      "name": "Jane Doe",
      "image": "assets/png/client-2.png",
      "review":
          "Seamlessly integrate impactful solutions with unparalleled innovation. Drive user-centric design while enhancing value-added interactions for long-term growth.",
    },
    {
      "name": "John Smith",
      "image": "assets/png/client-2.png",
      "review":
          "Efficiently implement adaptive processes and collaborative methodologies. Enable scalable systems for dynamic and evolving requirements.",
    },
  ];

  void nextPage() {
    if (currentIndex < testimonials.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth <= 1024;
    bool isDesktop = screenWidth > 1024;
    return Scaffold(
      endDrawer: DrawerScreen(),
      floatingActionButton: CustomFloatingbutton(),
      body: Stack(
        children: [
          Column(
            children: [
              //green container
              isDesktop ? HeaderGreencard() : SizedBox(),
              //main body container
              Expanded(
                  // flex: 8,
                  child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * (isDesktop ? 0.04 : 0.01),
                            vertical: screenHeight * (isDesktop ? 0.08 : 0.09)),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "About Us",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 25 : 35),
                              ),
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ));
                                    },
                                    child: Text(
                                      "Home >>",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isMobile ? 14 : 16),
                                    ),
                                  ),
                                  Text(
                                    "Page >> About",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 14 : 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: isMobile ? 20 : 100,
                            ),
                            //stack widgets and misson & vission
                            isDesktop
                                ? Row(
                                    children: [
                                      Column(
                                        children: [
                                          // stack items
                                          Stack(
                                            children: [
                                              Image.asset(
                                                "assets/png/aboutus.png",
                                                height: 650,
                                              ),
                                              Positioned(
                                                right: 10,
                                                bottom: 0,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  width: 350,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        " \"Assertively target market Lorem ipsum is simply free consectetur notted elit sed do eiusmod \"",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            child: Text(
                                                              "---------",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          Text(
                                                            "George Scholll",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF03AC13),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //organic food
                                          Row(
                                            children: [
                                              Text(
                                                "100% Organic Food Provide",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.orange,
                                                size: 25,
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Be healthy & eat fresh",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "organic food",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Assertively target market lorem ipsum is simply free text available dolor sit amet, consectetur notted adipisicing elit sed do eiusmod tempor incididunt simply freeutation labore et dolore.",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          //mission vission
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 300,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/png/clap.png",
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        "Our Mission",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 300,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.asset(
                                                        "assets/png/clap.png",
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        "Our Vision",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // stack items
                                        Stack(
                                          children: [
                                            Image.asset(
                                              "assets/png/aboutus.png",
                                              height: 650,
                                            ),
                                            Positioned(
                                              right: 10,
                                              bottom: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        isMobile ? 20 : 10,
                                                    vertical: 10),
                                                width: 350,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " \"Assertively target market Lorem ipsum is simply free consectetur notted elit sed do eiusmod \"",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Text(
                                                            "---------",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        Text(
                                                          "George Scholll",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF03AC13),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        //organic food
                                        Row(
                                          children: [
                                            Text(
                                              "100% Organic Food Provide",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.orange,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Be healthy & eat fresh",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "organic food",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Assertively target market lorem ipsum is simply free text available dolor sit amet, consectetur notted adipisicing elit sed do eiusmod tempor incididunt simply freeutation labore et dolore.",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //mission vission
                                        isTablet
                                            ? Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 300,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                            "assets/png/clap.png",
                                                            height: 50,
                                                          ),
                                                          Text(
                                                            "Our Mission",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 300,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Image.asset(
                                                            "assets/png/clap.png",
                                                            height: 50,
                                                          ),
                                                          Text(
                                                            "Our Vision",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : //mobile
                                            Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/png/clap.png",
                                                          height: 50,
                                                        ),
                                                        Text(
                                                          "Our Mission",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade200),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/png/clap.png",
                                                          height: 50,
                                                        ),
                                                        Text(
                                                          "Our Vision",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "Continually transform virtual meta- methodologies. leverage existing alignments.",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade200),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 40,
                            ),
                            //most popular brands
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20 : 0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "The Most Popular Brands",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          20,
                                          (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Container(
                                                width: 250,
                                                padding: EdgeInsets.all(20),
                                                child: Image.asset(
                                                  "assets/png/dh.png",
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            //working ability
                            isDesktop
                                ? Column(
                                    children: [
                                      Text(
                                        "Our Working Ability",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Assertively target market lorem ipsum is simply free text available dolor incididunt simply free ut labore et dolore.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(
                                          DummyDb.abilityDetails.length,
                                          (index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade200)),
                                              width: 250,
                                              child: ListTile(
                                                leading: Image.asset(
                                                  DummyDb.abilityDetails[index]
                                                      ['url'],
                                                  height: 100,
                                                ),
                                                title: Text(
                                                  DummyDb.abilityDetails[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  DummyDb.abilityDetails[index]
                                                      ['subtitle'],
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Our Working Ability",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Assertively target market lorem ipsum is simply free text available dolor incididunt simply free ut labore et dolore.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GridView.builder(
                                          itemCount:
                                              DummyDb.abilityDetails.length,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      isTablet ? 2 : 1,
                                                  mainAxisSpacing: 40,
                                                  mainAxisExtent: 80,
                                                  crossAxisSpacing: 20),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade200)),
                                              height: isTablet ? 100 : null,
                                              width: isTablet
                                                  ? 250
                                                  : double.infinity,
                                              child: ListTile(
                                                leading: Image.asset(
                                                  DummyDb.abilityDetails[index]
                                                      ['url'],
                                                  height: 100,
                                                ),
                                                title: Text(
                                                  DummyDb.abilityDetails[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  DummyDb.abilityDetails[index]
                                                      ['subtitle'],
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: isMobile ? 25 : 100,
                            ),

                            //scrolling content
                            isDesktop
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          "assets/png/clients_new.png",
                                          height: 500,
                                          width: 800,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            // Slider Box
                                            SizedBox(
                                              height: 250,
                                              child: PageView.builder(
                                                controller: _pageController,
                                                itemCount: testimonials.length,
                                                physics: ScrollPhysics(),
                                                onPageChanged: (index) {
                                                  setState(() {
                                                    currentIndex = index;
                                                  });
                                                },
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 12),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 35,
                                                              backgroundImage: AssetImage(
                                                                  testimonials[
                                                                          index]
                                                                      [
                                                                      'image']),
                                                            ),
                                                            SizedBox(width: 15),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  testimonials[
                                                                          index]
                                                                      ['name'],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Row(
                                                                  children: List
                                                                      .generate(
                                                                    5,
                                                                    (starIndex) =>
                                                                        Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          testimonials[index]
                                                              ['review'],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            // Sliding Buttons
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: previousPage,
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.orange.shade100,
                                                    child: Icon(
                                                      Icons.keyboard_arrow_left,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: nextPage,
                                                  child: CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.orange.shade100,
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/png/clients_new.png",
                                          height: 500,
                                          width: 800,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: isTablet ? 230 : 350,
                                          child: PageView.builder(
                                            controller: _pageController,
                                            itemCount: testimonials.length,
                                            physics: ScrollPhysics(),
                                            onPageChanged: (index) {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 12),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  testimonials[
                                                                          index]
                                                                      [
                                                                      'image']),
                                                        ),
                                                        SizedBox(width: 15),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              testimonials[
                                                                      index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Row(
                                                              children:
                                                                  List.generate(
                                                                5,
                                                                (starIndex) =>
                                                                    Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
                                                    Text(
                                                      testimonials[index]
                                                          ['review'],
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        // Sliding Buttons
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: previousPage,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.orange.shade100,
                                                child: Icon(
                                                  Icons.keyboard_arrow_left,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: nextPage,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.orange.shade100,
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: isMobile ? 15 : 100,
                            ),

                            //online customer
                            isDesktop
                                ? Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //team members
                                          Row(
                                            children: [
                                              Text(
                                                "Team members",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.orange,
                                                size: 25,
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Our Online",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          Text(
                                            "Customer Help !",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          Text(
                                            "Member",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          Text(
                                            "Rationally encounter extremely painful there anyone.",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          //buttons
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: scrollLeft,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.keyboard_arrow_left,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              GestureDetector(
                                                onTap: scrollRight,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          controller: _scrollController,
                                          child: Row(
                                            children: List.generate(
                                              DummyDb.ceolist.length,
                                              (index) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      height: 250,
                                                      width: 300,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            height: 150,
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(DummyDb
                                                                              .ceolist[
                                                                          index]
                                                                      ['url']),
                                                              radius: 50,
                                                            ),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .blue)),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            DummyDb.ceolist[
                                                                index]['name'],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          Text(
                                                            DummyDb.ceolist[
                                                                index]['desig'],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 18),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade200),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Team members",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: isTablet ? 20 : 18),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.orange,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Our Online Customer Help ! Member",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: isTablet ? 30 : 22),
                                        ),
                                        Text(
                                          "Rationally encounter extremely painful there anyone.",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        //buttons
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: scrollLeft,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.green,
                                                child: Icon(
                                                  Icons.keyboard_arrow_left,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: scrollRight,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: Colors.green,
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 280,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            controller: _scrollController,
                                            child: Row(
                                              children: List.generate(
                                                DummyDb.ceolist.length,
                                                (index) {
                                                  return Row(
                                                    children: [
                                                      Container(
                                                        height: 250,
                                                        width: 300,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              height: 150,
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundImage:
                                                                    AssetImage(DummyDb
                                                                            .ceolist[index]
                                                                        [
                                                                        'url']),
                                                                radius: 50,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .blue)),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              DummyDb.ceolist[
                                                                      index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                            Text(
                                                              DummyDb.ceolist[
                                                                      index]
                                                                  ['desig'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 18),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: isMobile ? 15 : 80,
                            ),

                            //organic food ad
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 20 : 0),
                              child: Container(
                                height: 300,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Weekend Offer",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.orange,
                                            size: 30,
                                          )
                                        ],
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Organic Foods Upto 40 % off",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 25 : 30),
                                      ),
                                      ShopAndAboutButton(
                                          isWidth: true,
                                          text: "Shop Now",
                                          buttonColor: Colors.orange)
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/png/organic.jpg"))),
                              ),
                            ),
                            SizedBox(
                              height: isMobile ? 15 : 100,
                            ),
                            //why choose us
                            isDesktop
                                ? Row(
                                    children: [
                                      Column(
                                        children: [
                                          //stack items
                                          Stack(
                                            children: [
                                              Image.asset(
                                                "assets/png/ab-2_new.png",
                                                height: 500,
                                              ), //experience card
                                              Positioned(
                                                right: 30,
                                                child: CircleAvatar(
                                                  radius: 80,
                                                  backgroundColor:
                                                      Colors.orange,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "14+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 45),
                                                          ),
                                                          Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "Year's Experience",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Why Choose Us",
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.orange,
                                                  size: 25,
                                                )
                                              ],
                                            ),
                                            Text(
                                              "We do not Buy from the Open Market",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ),
                                            Text(
                                              "Compellingly fashion intermandated opportunities and multimedia based fnsparent e-business.",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GridView.builder(
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  DummyDb.gridDetails.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 10,
                                                      mainAxisExtent: 150,
                                                      mainAxisSpacing: 20),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 20),
                                                  // height: 220,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/png/clap.png",
                                                        height: 40,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              DummyDb.gridDetails[
                                                                      index]
                                                                  ['title'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                softWrap: true,
                                                                DummyDb.gridDetails[
                                                                        index]
                                                                    ['desc'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade200)),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : //other devices
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isTablet ? 20 : 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //stack items
                                        Stack(
                                          children: [
                                            Image.asset(
                                              "assets/png/ab-2_new.png",
                                              height: 600,
                                            ), //experience card
                                            Positioned(
                                              right: isTablet ? 50 : 10,
                                              top: isTablet ? 0 : 100,
                                              child: CircleAvatar(
                                                radius: 80,
                                                backgroundColor: Colors.orange,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "14+",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 45),
                                                        ),
                                                        Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          "Year's Experience",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Text(
                                              "Why Choose Us",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: isTablet ? 18 : 15),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.orange,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "We do not Buy from the Open Market",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: isTablet ? 30 : 22),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Compellingly fashion intermandated opportunities and multimedia based fnsparent e-business.",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: isTablet ? 18 : 15),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GridView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: DummyDb.gridDetails.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount:
                                                      isTablet ? 2 : 1,
                                                  crossAxisSpacing: 10,
                                                  mainAxisExtent: 150,
                                                  mainAxisSpacing: 20),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 20),
                                              // height: 220,
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/png/clap.png",
                                                    height: 40,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          DummyDb.gridDetails[
                                                              index]['title'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            softWrap: true,
                                                            DummyDb.gridDetails[
                                                                index]['desc'],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade200)),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      //footer part
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 30 : 5, vertical: 35),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isMobile
                                  ? Column(
                                      children: [
                                        Text(
                                          "Subscribe to the GOMART",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "New Arrivals",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Subscribe to the GOMART",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "New Arrivals",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "& Other information.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: isTablet ? double.infinity : 500,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Enter Email Address",
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Homepage(),
                                            ));
                                      },
                                      child: Container(
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "Subscribe Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Divider(
                                color: Colors.white.withAlpha(80),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Divider(
                                color: Colors.white.withAlpha(80),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Row(
                                  children: [
                                    Text(
                                      "All rights reserved Made by",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "GoMart",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    isDesktop
                                        ? SizedBox(
                                            width: 400,
                                          )
                                        : SizedBox(),
                                    isDesktop
                                        ? Row(
                                            children: [
                                              Text(
                                                "Go",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 40,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "mart",
                                                style: TextStyle(
                                                    color: Color(0xFF03AC13),
                                                    fontSize: 40,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                color: Colors.white,
              ))
            ],
          ),
          //small container (appbar)
          Positioned(
            left: 0,
            right: 0,
            top: isDesktop ? screenHeight * (isMobile ? 0.06 : 0.05) : 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * (isDesktop ? 0.04 : 0)),
              child: HeaderWhitebox(),
            ),
          )
        ],
      ),
    );
  }
}

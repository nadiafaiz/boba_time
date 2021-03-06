import 'package:boba_time/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:boba_time/model/model.dart';
import 'package:boba_time/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  final bool isGuest;

  const HomeScreen({Key? key, required this.isGuest}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  var currentUser = UserModel();

  @override
  void initState() {
    super.initState();
    if (!widget.isGuest) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        currentUser = UserModel.fromMap(value);
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
        fullName: currentUser.fullName,
        email: currentUser.email,
      ),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffffd8cf),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              color: const Color(0xfff2aea2),
              child: Image.asset(
                'assets/images/home.png',
              ),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xfff0edca),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentUser.fullName != null
                          ? Align(
                              alignment: Alignment.center,
                              child: AppText.normalText(
                                'Welcome ${currentUser.fullName}!',
                                isBold: true,
                              ),
                            )
                          : Align(
                              alignment: Alignment.center,
                              child: AppText.normalText(
                                'Welcome!',
                                isBold: true,
                              ),
                            ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (currentUser.fullName != null) InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RewardScreen();
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.card_giftcard),
                            Text('Rewards'),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LocationScreen();
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.location_on),
                            Text('Locations'),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MenuScreen();
                              },
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Icon(Icons.restaurant_menu),
                            Text('Menu'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

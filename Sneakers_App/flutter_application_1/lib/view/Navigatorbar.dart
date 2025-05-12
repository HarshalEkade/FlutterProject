import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/ShoeModel.dart';
import 'package:flutter_application_1/view/FavouriteScreen.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'package:flutter_application_1/view/notifications.dart';
import 'package:flutter_application_1/view/profile_screen.dart';

Widget navigatorBar(BuildContext context, List<Shoe> favoriteItems) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    child: Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(13, 110, 253, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return Homepage(
                      email: '',
                    );
                  }),
                );
              },
              child: const Icon(
                Icons.home,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 30,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(
                      favoriteItems: favoriteItems,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.favorite,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 30,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const Notifications();
                  }),
                );
              },
              child: const Icon(
                Icons.notifications,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 30,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }),
                );
              },
              child: const Icon(
                Icons.person,
                color: Color.fromRGBO(255, 255, 255, 1),
                size: 30,
              ),
            ),
          ],
        ),
      ),
),
);
}
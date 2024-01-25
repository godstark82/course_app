import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:course_app/screens/home/components/drawer.dart';
import 'package:course_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notepediax'),
        ),
        drawer: const MyDrawer(),
        body: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, value, child) {
            return screen[value];
          },
        ),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, value, child) {
              return BottomBarCreative(
                items: items,
                backgroundColor: Colors.white,
                color: Colors.black,
                colorSelected: Colors.blue,
                indexSelected: value,
                onTap: (newIndex) {
                  selectedIndex.value = newIndex;
                },
              );
            }));
  }

  List<Widget> screen = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.search_sharp,
      title: 'Shop',
    ),
    const TabItem(
      icon: FontAwesomeIcons.bookOpenReader,
      title: 'Wishlist',
    ),
    const TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Cart',
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'profile',
    ),
  ];
}

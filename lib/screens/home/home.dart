
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:course_app/constants/widgets/skeleton_widget.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:course_app/screens/category/category_screen.dart';
import 'package:course_app/screens/home/components/drawer.dart';
import 'package:course_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
          elevation: 2,
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder(
            future: Future.wait([
              context.read<CourseProvider>().fetchCourses(),
              context.read<CategoryProvider>().fetchCategories(),
              context.read<CarouselProvider>().fetchCarousel(),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SkeletonWidget();
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return ValueListenableBuilder(
                  valueListenable: selectedIndex,
                  builder: (context, value, child) {
                    return screen[value];
                  },
                );
              }
            }),
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
                  });
            }));
  }

  List<Widget> screen = <Widget>[
    const HomeScreen(),
    const CategoryScreen(),
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
      icon: Icons.catching_pokemon,
      title: 'Category',
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

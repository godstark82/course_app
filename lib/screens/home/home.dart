import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:course_app/constants/utils/utils.dart';
import 'package:course_app/constants/widgets/skeleton_widget.dart';
import 'package:course_app/provider/carousel_provider.dart';
import 'package:course_app/provider/category_provider.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/home/components/drawer.dart';
import 'package:course_app/screens/home/home_screen.dart';
import 'package:course_app/screens/quiz/quiz_screen.dart';
import 'package:course_app/screens/study/study_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: GlobalKeys.homeScaffoldKey,
        appBar: AppBar(
          title: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) {
                if (value == 0) {
                  return const Text('Notepediax').text.bold.make();
                }
                if (value == 1) {
                  return const Text('Notes').text.bold.make();
                }
                if (value == 3) {
                  return const Text('Quizes').text.bold.make();
                } else {
                  return const Text('Store').text.bold.make();
                }
              }),
          elevation: 2,
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder(
            future: Future.wait([
              // Courses has been fetched in fetchUserCourses function
              context.read<UserProvider>().fetchUserCourses(context),
              // context.read<CourseProvider>().fetchCourses(),
              context.read<CarouselProvider>().fetchCarousel(),
              context.read<CategoryProvider>().fetchCategories(),
              context.read<QuizProvider>().fetchQuizes(),
              context.read<QuizProvider>().fetchUserQuiz()
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
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, color: Colors.grey)
                  ],
                  enableShadow: true,
                  isFloating: true,

                  // backgroundSelected: Colors.red,
                  // animated: true,
                  items: items,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  colorSelected: Colors.blue,
                  indexSelected: value,
                  onTap: (newIndex) async {
                    if (newIndex == 2) {
                      await Get.to(() => const StudyScreen());
                      selectedIndex.value = 0;
                    } else {
                      selectedIndex.value = newIndex;
                    }
                  });
            }));
  }

  List<Widget> screen = <Widget>[
    const HomeScreen(),
    const QuizScreen(isUserQuizes: false),
    const StudyScreen(),
    const QuizScreen(isUserQuizes: false),
    const ProfileScreen()
  ];

  List<TabItem> items = [
    const TabItem(
      icon: Ionicons.home_outline,
      title: 'Home',
    ),
    const TabItem(
      icon: Ionicons.tablet_landscape_outline,
      title: 'Notes',
    ),
    const TabItem(
      icon: Ionicons.book_outline,
      title: 'Study',
    ),
    const TabItem(
      icon: Ionicons.bulb_outline,
      title: 'Quiz',
    ),
    const TabItem(
      icon: Ionicons.storefront_outline,
      title: 'Store',
    ),
  ];
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

ValueNotifier<int> selectedIndex = ValueNotifier(0);


// Home
// Courses
/* Quiz
   Notes
   Store
 */

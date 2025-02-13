import 'package:trogon_test/src/presentation/provider/home_provider.dart';
import 'package:trogon_test/src/presentation/screens/home/tabs/home_tab.dart';
import 'package:trogon_test/src/presentation/screens/home/tabs/notifications_tab.dart';
import 'package:trogon_test/src/presentation/screens/home/tabs/profile_tab.dart';
import 'package:trogon_test/src/presentation/screens/home/tabs/subjects_tab.dart';

import '../../../../exports_main.dart';
import '../../../core/constants/app_svgs.dart';
import '../../../core/utils/app_colors.dart';
import '../../widgets/custom_svg_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<HomeScreen> {
  DateTime? _lastPressedAt;
  Future<bool> handleBackPress(BuildContext context) async {
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Press again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false; // Prevents the app from closing immediately
    }
    return true; // Allows the app to close if pressed again within 2 seconds
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        handleBackPress(context);
      },
      child: Scaffold(
        body: IndexedStack(
          index: state.currentIndex,
          children: [
            HomeTab(),
            const SubjectsTab(),
            const NotificationsTab(),
            const ProfileTab(),
          ],
        ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, state, child) {
            return Stack(
              children: [
                BottomNavigationBar(
                  enableFeedback: true,
                  backgroundColor: Colors.white,
                  elevation: 4,
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 9,
                  unselectedFontSize: 9,
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    state.updateIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: SvgIcon(path: AppSvgs.homeIconFilled),
                      icon: SvgIcon(path: AppSvgs.homeIcon),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgIcon(path: AppSvgs.allCoursesIconFilled),
                      icon: SvgIcon(path: AppSvgs.allCoursesIcon),
                      label: 'All Subjects',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgIcon(path: AppSvgs.notificationIconFilled),
                      icon: SvgIcon(path: AppSvgs.notificationIcon),
                      label: 'Notification',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: SvgIcon(path: AppSvgs.profileIconFilled),
                      icon: SvgIcon(path: AppSvgs.profileIcon),
                      label: 'Profile',
                    ),
                  ],
                ),

                //

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => state.currentIndex == index
                        ? AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            height: 4,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.lightblueColor,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                          )
                        : AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 300),
                            height: 4,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

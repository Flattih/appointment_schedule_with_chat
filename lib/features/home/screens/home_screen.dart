import 'package:appointment_schedule_app/core/extensions/context_extension.dart';
import 'package:appointment_schedule_app/core/utils/dynamicc_link.dart';
import 'package:appointment_schedule_app/features/chat/widgets/contact_list.dart';
import 'package:appointment_schedule_app/features/home/delegates/search_user_delegates.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:routemaster/routemaster.dart';
import 'package:unicons/unicons.dart';
import '../../../core/common/error_Text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/post_card.dart';
import '../../../core/providers/firebase_providers.dart';
import '../../add_appointment/controller/post_controller.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/repository/auth_repository.dart';
import '../../profile/screens/bottom_bar_profile_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int _bottomNavIndex = 0;
  List screens = [
    const FeedsScreen(),
    ContactsList(),
    const BottomBarProfileScreen()
  ];
  late AnimationController controller;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
    //ref.read(authControllerProvider.notifier).setUserState(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        await ref.read(authControllerProvider.notifier).setUserState(true);
        break;
      case AppLifecycleState.inactive:
        await ref.read(authControllerProvider.notifier).setUserState(false);
        break;

      case AppLifecycleState.detached:
        await ref.read(authControllerProvider.notifier).setUserState(false);
        break;
      case AppLifecycleState.paused:
        await ref.read(authControllerProvider.notifier).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    DynamicLinkPro().initDynamic(ref, context);
    return Scaffold(
        floatingActionButton: !ref.watch(authProvider).currentUser!.isAnonymous
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Routemaster.of(context).push('/a');
                },
              )
            : const SizedBox(),
        key: scaffoldKey,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            color: Theme.of(context).bottomAppBarColor,
            boxShadow: [BoxShadow(blurRadius: 20, color: context.primaryColor)],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: GNav(
                  activeColor: Theme.of(context).primaryColor,
                  tabBackgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  gap: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  iconSize: 24,
                  color: Colors.grey,
                  selectedIndex: _bottomNavIndex,
                  onTabChange: (index) {
                    setState(() {
                      _bottomNavIndex = index;
                    });
                  },
                  tabs: [
                    GButton(
                      text: "Home".tr(),
                      icon: UniconsLine.home,
                    ),
                    GButton(
                      icon: UniconsLine.chat,
                      text: "Messages".tr(),
                    ),
                    GButton(
                      icon: UniconsLine.user,
                      text: "Profile".tr(),
                    ),
                  ]),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: SearchCommunityDelegate(ref));
              },
              icon: const Icon(Icons.search),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                  onTap: () {
                    ref.read(authRepositoryProvider).signOutGoogle();
                    ref
                        .read(authControllerProvider.notifier)
                        .setUserState(false);
                  },
                  child: const Icon(Icons.logout)),
            ),
          ],
        ),
        body: screens[_bottomNavIndex]);
  }
}

class FeedsScreen extends ConsumerWidget {
  const FeedsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(allPostsProvider).when(
        data: (data) {
          return data.isEmpty
              ? Center(
                  child: Text("no-poll-to-show".tr()),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final post = data[index];
                    return index.isOdd
                        ? PostCard(post: post)
                            .animate()
                            .fadeIn()
                            .scale()
                            .move(delay: 300.ms, duration: 600.ms)
                        : PostCard(post: post)
                            .animate()
                            .fadeIn(delay: 300.ms, duration: 500.ms)
                            .then()
                            .slide(duration: 400.ms)
                            .then(delay: 200.ms)
                            .move(delay: 0.ms);
                  },
                );
        },
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}

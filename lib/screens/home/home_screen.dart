import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnon/screens/offer/offer_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../localization/localization_constants.dart';
import '../account/account_screen.dart';
import '../home_data/favorite_list/bloc/fav_cubit.dart';
import '../home_data/favorite_list/bloc/fav_state.dart';
import '../home_data/favorite_list/favorite_list_screen.dart';
import '../home_data/home_data_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.initialIndex, {Key? key, this.email}) : super(key: key);
  String? email;

  int? initialIndex;
  bool? isLikeCard=false;

  @override
  _HomeScreenState createState() => _HomeScreenState(this.initialIndex);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this.initialIndex);
  int? initialIndex;

  @override
  Widget build(BuildContext context) {
    final _controller = PersistentTabController(initialIndex:initialIndex!);
    return BlocProvider(
      create: (context) => FavCubit()..createDataBase()/*..getSettings(widget.lang)*/,
      child: BlocConsumer<FavCubit, FavState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<Widget> _buildScreens() {

            return [
              HomeDataScreen(context,"01015444444",
                  FavCubit.get(context).favList
                /*,settingsModel!.data!.contactData!.mobile!*/),
              /*CartScreen(context,widget.lang,settingsModel.data!.contactData!.mobile!),*/
              OfferScreen(context,"010101010000"/*settingsModel.data!.contactData!.mobile!*/),
              FavoriteListScreen("ddd",context,),
              AccountScreen(context, widget.email!,"01010011000"
                /*settingsModel!.data!.contactData!.mobile!*/),
            ];
          }

          List<PersistentBottomNavBarItem> _navBarsItems() {
            return [
              PersistentBottomNavBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: (getTranslated(context, "Home",)!
                ),
                activeColorPrimary: HexColor("#50555C"),
                inactiveColorPrimary: HexColor("#9098B1"),
              ),



              PersistentBottomNavBarItem(
                icon: const Icon(Icons.local_offer_outlined),
                title: (getTranslated(context, "Offers",)!),
                activeColorPrimary: HexColor("#50555C"),
                inactiveColorPrimary: HexColor("#9098B1"),
              ),

              PersistentBottomNavBarItem(
                icon: const Icon(Icons.favorite_outline),
                title: (getTranslated(context, "Favorite",)!),
                activeColorPrimary: HexColor("#50555C"),
                inactiveColorPrimary: HexColor("#9098B1"),
              ),
              PersistentBottomNavBarItem(
                icon: /*settingsModel!.data!.cartNumber==0?*/
                const Icon(Icons.settings),
                /*Badge(
                  toAnimate: true,
                  animationType: BadgeAnimationType.slide,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.red,
                  child: const Icon(Icons.shopping_cart_outlined),
                  borderRadius: BorderRadius.circular(10),
                  badgeContent: customText(settingsModel.data!.cartNumber.toString()
                      , color: Colors.white, size: 12),
                ),*/
                title: "الاعدادات",
                activeColorPrimary: HexColor("#50555C"),
                inactiveColorPrimary: HexColor("#9098B1"),
              ),
            ];
          }
          return /*settingsModel==null?
          Scaffold(
            body: const Center(
                child:  SpinKitChasingDots(
                  color: customColor,
                  size: 40,
                )),
          ):*/
          PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            backgroundColor: Colors.white,
            // Default is Colors.white.
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            // Default is true.
            hideNavigationBarWhenKeyboardShows: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style6, // Choose the nav bar style with this property.
          );
        },
      ),
    );
  }

}


class FirstScreen extends StatelessWidget {
  FirstScreen(this.email, {Key? key}) : super(key: key);
  String? email;

  @override
  Widget build(BuildContext context) {
    return HomeScreen(0,
        email: email == null ? "" : email);
  }
}

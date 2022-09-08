import 'package:flutter/material.dart';
import 'package:solomonic/view/Pages/Homescreen.dart';
import 'package:solomonic/view/Pages/bookcarList.dart';
import 'package:solomonic/view/Pages/profilescree.dart';
class mainscreen extends StatefulWidget {
  const mainscreen({Key? key}) : super(key: key);

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  int _pageIndex = 0;
  PageController _pageController = PageController(initialPage:0);

  List<Widget> _screens =
  [homescreen(),bookingcarlist(),profilescreen()
  ];
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor:Colors.black,
            selectedItemColor:Colors.white
            ,
            unselectedItemColor:Colors.white70,
            showUnselectedLabels: true,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _barItem(Icons.home,"Home", 0),
              _barItem(Icons.list_alt,"Booking", 1),
              _barItem(Icons.perm_identity,"Profile", 2),


            ],
            onTap: (int index) {
              _setPage(index);
            },
          ),

          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          ),

        ));
  }
  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, children: [
        Icon(icon, color: index == _pageIndex ? Colors.white : Colors.white70, size: 25),
      ],
      ),
      label: label,
    );
  }
  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}

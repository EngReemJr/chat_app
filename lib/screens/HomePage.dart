import 'package:chat_part/auth/providers/auth_ptoviders.dart';
import 'package:chat_part/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import 'chatPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
 late PageController _pageController;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      if(index == 1){
        Provider.of<AuthProvider>(context,listen: false).setNotificationCounter();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            ChatPage(),
            notification_list(),

          ],
        ),
      ),

      //ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",

          ),
          BottomNavigationBarItem(
            icon:
                Provider.of<AuthProvider>(context).notification_counter >= 1 ?
                badges.Badge(
                  child:Icon (Icons.notifications_active_sharp),
                    badgeContent: Text(
                      '${Provider.of<AuthProvider>(context).notification_counter}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    )
                )
            :
                Icon (Icons.notifications_active_sharp)
             ,

            label: "Notifications",

          ),
          
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

      ),
    );
  }
}
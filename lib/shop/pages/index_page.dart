import 'package:bigdata/shop/pages/cart_page.dart';
import 'package:bigdata/shop/pages/member_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../shop/config/index.dart';
import '../../shop/provide/current_index_provide.dart';

import 'category_page.dart';
import 'home_page.dart';

class IndexPage extends StatelessWidget {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(KString.homeTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.category), title: Text(KString.categoryTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text(KString.shoppingCartTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.person), title: Text(KString.memberTitle)),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  @override
  Widget build(BuildContext context) {

    final provide=Provide.value<BNBIndexObservable>(context);

    ScreenUtil.instance= ScreenUtil(width: 750,height: 1334)..init(context);

    return Provide<BNBIndexObservable>(
      builder: (context, child, val) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 244, 244, 1.0),
          body: IndexedStack(
            index: val.value,
            children: tabBodies,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomTabs,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              val.changeIndex(index);
            },
          ),

        );
      },
    );
  }
}

import 'package:animated_drawer_3d/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.backgroundColor,
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: DrawerItemSelector(
                items: drawerMenuTitles,
                selectedLabelColor: CustomColor.selectedItemColor,
                unSelectedLabelColor: CustomColor.black,
                onChange: (index) {
                  print(index);
                },
              ),
            ),
            Positioned(
              left: 0,
              bottom: 10,
              right: 0,
              child: DrawerFooterBuilder(
                items: footerItems,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerFooterBuilder extends StatelessWidget {
  final List<String> items;
  final TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 16);

  DrawerFooterBuilder({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            items[index],
            style: _textStyle,
          ),
        );
      },
    );
  }
}

class DrawerItemSelector extends StatefulWidget {
  final List<String> items;
  final Color unSelectedLabelColor;
  final Color selectedLabelColor;
  final ValueChanged<int> onChange;

  const DrawerItemSelector({
    Key key,
    this.items,
    this.unSelectedLabelColor,
    this.selectedLabelColor,
    this.onChange,
  }) : super(key: key);
  @override
  _DrawerItemSelectorState createState() => _DrawerItemSelectorState();
}

class _DrawerItemSelectorState extends State<DrawerItemSelector> {
  int selectedIndex = 0;
  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;
  @override
  void initState() {
    selectedTextStyle = GoogleFonts.viga(
      textStyle: TextStyle(
        color: widget.selectedLabelColor ?? Colors.black,
        fontSize: 36,
      ),
    );
    unSelectedTextStyle = GoogleFonts.viga(
      textStyle: TextStyle(
        color: widget.unSelectedLabelColor ?? Colors.black,
        fontSize: 36,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            if (selectedIndex != index) {
              setState(() {
                selectedIndex = index;
              });
              widget.onChange(index);
            }
          },
          child: Text(
            widget.items[index],
            style: index == selectedIndex
                ? selectedTextStyle
                : unSelectedTextStyle,
          ),
        );
      },
    );
  }
}

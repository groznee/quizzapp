import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//this is a list for the NavigationBar, for the NavigationRail we map the list
const leDestinazioni = [
  NavigationDestination(
    icon: Icon(
      FontAwesomeIcons.graduationCap,
      size: 20,
    ),
    label: 'Topics',
  ),
  NavigationDestination(
    icon: Icon(
      FontAwesomeIcons.bolt,
      size: 20,
    ),
    label: 'About',
  ),
  NavigationDestination(
    icon: Icon(
      FontAwesomeIcons.circleUser,
      size: 20,
    ),
    label: 'Profile',
  ),
];

// helper f-ion to make the navigation bar darker
Color computeBackColor(context) {
  var backColor = HSLColor.fromColor(Theme.of(context).primaryColorDark);
  backColor = backColor.withLightness(0.15);
  return backColor.toColor();
}

void dealWithNav(context, idx) {
  switch (idx) {
    case 0:
      // do nothing
      break;
    case 1:
      Navigator.pushNamed(context, '/about');
      break;
    case 2:
      Navigator.pushNamed(context, '/profile');
      break;
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: leDestinazioni,
      backgroundColor: computeBackColor(context),
      height: 64,
      onDestinationSelected: (int idx) {
        dealWithNav(context, idx);
      },
    );
  }
}

class LeftNavRail extends StatelessWidget {
  const LeftNavRail({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      labelType: NavigationRailLabelType.all,
      destinations: leDestinazioni.map((destinazioni) {
        return NavigationRailDestination(
          icon: destinazioni.icon,
          label: Text(
            destinazioni.label,
            style: TextStyle(
                color: Theme.of(context).indicatorColor,
                fontSize: 14,
                height: 2),
          ),
        );
      }).toList(),
      backgroundColor: computeBackColor(context).withOpacity(0.6),
      onDestinationSelected: (int idx) {
        dealWithNav(context, idx);
      },
    );
  }
}

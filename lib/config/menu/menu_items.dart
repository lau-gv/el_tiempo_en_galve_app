import 'package:flutter/material.dart';


class MenuItem {
  final String title;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.link,
    required this.icon
  });
}


const appMenuItems = <MenuItem>[


  MenuItem(
    title: 'Inicio', 
    link: '/', 
    icon: Icons.home_outlined,
  ),

  MenuItem(
    title: 'Mis estaciones',  
    link: '/stations', 
    icon: Icons.add_link_rounded
  ),

  MenuItem(
    title: 'Datos de hoy', 
    link: '/detail-current-data', 
    icon: Icons.credit_card
  ),

  MenuItem(
    title: 'Historico de datos', 
    link: '/historical-data', 
    icon: Icons.refresh_rounded
  ),
];




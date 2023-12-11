import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc426_front/notifications/notifications.dart';
import 'package:mc426_front/profile/profile.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback logout;
  const HomeDrawer({required this.logout, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF5F5F5F),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: SvgPicture.asset(
                      "assets/images/sign_icon.svg",
                      width: 38,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Fechar',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(ProfilePage.routeName),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Perfil',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(UserPostsPage.routeName),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.list_alt_sharp,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Meus Posts',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(NotificationsPage.routeName),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Notificações',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: logout,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        size: 32,
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Sair',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

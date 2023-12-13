import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc426_front/complaint/complaint.dart';
import 'package:mc426_front/home/domain/domain.dart';

class HomeUserWidget extends StatelessWidget {
  final VoidCallback panicButton;
  final HomeUserEntity user;
  const HomeUserWidget({required this.user, super.key, required this.panicButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF5F5F5F),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.black,
                backgroundImage: user.photo != null
                    ? Image.file(
                        File(user.photo!),
                        fit: BoxFit.cover,
                      ).image
                    : null,
                child: user.photo == null
                    ? SvgPicture.asset(
                        "assets/images/sign_icon.svg",
                        width: 16,
                      )
                    : null,
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${user.qtdPosts} posts",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(ComplaintPage.routeName),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text("Publicar"),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: ElevatedButton(
                  onPressed: panicButton,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return const Color(0xFFC53D46);
                      },
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8),
                      Text("SOS"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

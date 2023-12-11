import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc426_front/profile/profile.dart';

class UserPostsLoadedView extends StatelessWidget {
  final UserPostEntity userPost;

  const UserPostsLoadedView({required this.userPost, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: userPost.posts.length,
        itemBuilder: (context, index) {
          final post = userPost.posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF5F5F5F),
                      child: userPost.header.photo == null
                          ? SvgPicture.asset(
                              "assets/images/sign_icon.svg",
                              width: 16,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userPost.header.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          post.time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Local: ${post.local}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.thumb_up_off_alt_outlined,
                          color: Color(0xFF4CE5B1),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${post.upVotes} Curtidas",
                          style: const TextStyle(
                            color: Color(0xFF4CE5B1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.thumb_down_alt_outlined,
                          color: Color(0xFFC53D46),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${post.downVotes} Descurtidas",
                          style: const TextStyle(
                            color: Color(0xFFC53D46),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc426_front/home/domain/domain.dart';

class HomePostWidget extends StatefulWidget {
  final HomePostEntity post;
  final ValueChanged<bool> vote;
  const HomePostWidget({required this.post, required this.vote, super.key});

  @override
  State<HomePostWidget> createState() => _HomePostWidgetState();
}

class _HomePostWidgetState extends State<HomePostWidget> {
  late bool upVote = widget.post.userUpVoted;
  late bool downVote = widget.post.userDownVoted;
  late int upVotes = widget.post.upVotes;
  late int downVotes = widget.post.downVotes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF5F5F5F),
              child: widget.post.photo == null || widget.post.isAnonymous
                  ? SvgPicture.asset(
                      "assets/images/sign_icon.svg",
                      width: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              widget.post.name != null && !widget.post.isAnonymous ? widget.post.name! : "Anônimo",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.post.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Local: ${widget.post.local}",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: !upVote
                  ? () {
                      widget.vote(true);
                      setState(() {
                        if (downVote) downVotes--;
                        upVotes++;
                        upVote = true;
                        downVote = false;
                      });
                    }
                  : null,
              child: Row(
                children: [
                  Icon(
                    upVote ? Icons.thumb_up_off_alt_sharp : Icons.thumb_up_off_alt_outlined,
                    color: const Color(0xFF4CE5B1),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$upVotes Curtir",
                    style: const TextStyle(
                      color: Color(0xFF4CE5B1),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: !downVote
                  ? () {
                      widget.vote(false);
                      setState(() {
                        if (upVote) upVotes--;
                        downVotes++;
                        downVote = true;
                        upVote = false;
                      });
                    }
                  : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    downVote ? Icons.thumb_down_alt_sharp : Icons.thumb_down_alt_outlined,
                    color: const Color(0xFFC53D46),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$downVotes Descurtir",
                    style: const TextStyle(
                      color: Color(0xFFC53D46),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

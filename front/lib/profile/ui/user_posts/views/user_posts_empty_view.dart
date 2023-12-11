import 'package:flutter/material.dart';
import 'package:mc426_front/complaint/complaint.dart';

class UserPostEmptyView extends StatelessWidget {
  const UserPostEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Você ainda não possui nenhuma publicação. \n\nAssim que você fizer uma nova publicação ela aparecerá aqui",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
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
        ],
      ),
    );
  }
}

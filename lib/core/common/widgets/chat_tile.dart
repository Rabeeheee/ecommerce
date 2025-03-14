import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.image,
    this.onTap,
  });

  final String name;
  final String lastMessage;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        backgroundColor: Colors.red,
      ),
      title: const Text('Name'),
      subtitle: const Text('Last Message'),
      trailing: const CircleAvatar(
        radius: 5,
        backgroundColor: Colors.red,
      ),
      onTap: () {
        GoRouter.of(context).pushNamed(
          AppRouteConstants.messagePage,
        );
      },
    );
  }
}

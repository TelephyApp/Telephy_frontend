import 'package:flutter/material.dart';

class RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(124, 129, 255, 1),
                Color.fromRGBO(174, 178, 253, 1),
                Color.fromRGBO(215, 216, 255, 0)
              ]),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: const Color(0xFF000000),
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

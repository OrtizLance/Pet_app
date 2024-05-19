import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final IconData icon;
  final void Function()? onPressed;
  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black26,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ListTile(
            leading: Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              text,
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
            subtitle: Text(
              sectionName,
              style: GoogleFonts.montserrat(fontSize: 20),
            ),
            trailing: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.settings,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

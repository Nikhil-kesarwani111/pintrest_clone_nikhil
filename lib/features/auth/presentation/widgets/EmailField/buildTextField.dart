import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
Widget buildTextField(BuildContext context) {
  return TextField(
    readOnly: true,
    onTap: () {
      context.pushNamed('clerkAuth');
    },
    decoration: InputDecoration(
      hintText: 'Email address',
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey[600],
        fontSize: 16.sp(context),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h(context),
        horizontal: 20.w(context),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide:  BorderSide(color: Colors.grey.shade500),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide:  BorderSide(color: Colors.grey.shade500),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
    ),
  );
}

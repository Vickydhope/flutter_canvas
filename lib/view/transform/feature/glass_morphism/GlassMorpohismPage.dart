import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';

class GlassMorphismPage extends StatelessWidget {
  const GlassMorphismPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(16);
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Assets.imagesImg2), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          title: const Text(
            "Glass Morphism",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(5, 5),
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 100),
            ]),
            child: Center(
              child: ClipRRect(
                borderRadius: border,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: border,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        width: 2,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Glass Morphism",
                      style: TextStyle(color: Colors.black54, fontSize: 24),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/neumorphism/components/neomorphism_container.dart';

class NeoMorphismPage extends StatelessWidget {
  const NeoMorphismPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NeoMorphismContainer(
              child: Text("Hello"),
            ),
            const SizedBox(height: 50),
            NeoMorphismContainer(
                shape: BoxShape.circle,
                child: Image.asset(
                  Assets.imagesImg4,
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}

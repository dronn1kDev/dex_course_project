import 'package:dex_course_temp/core/presentation/asset/image_collection.dart';
import 'package:dex_course_temp/features/init/presentation/init_vm.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  final InitViewModel vm;

  const InitPage({
    super.key,
    required this.vm,
  });

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  late final double screenHeight = MediaQuery.of(context).size.height;
  late final double screenWidth = MediaQuery.of(context).size.width;
  @override
  void initState() {
    super.initState();
    widget.vm.goToAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * .36),
                child: Image.asset(
                  ImageCollection.logo,
                  scale: 2,
                ),
              ),
              Container(
                height: 48,
                width: 48,
                margin: EdgeInsets.only(bottom: screenHeight * .1),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

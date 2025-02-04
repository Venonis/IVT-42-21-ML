import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Details',
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/test_image.jpg',
                  width: 300,
                  height: 200,
                ),
              ),
              
              Text(
                'Article 1.',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              20.ph,
              Text(
                'Details for Article 1.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
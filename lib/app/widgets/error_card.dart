// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_application_1/app/app.dart';
part of 'widgets.dart';

class ErrorCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCard({
    super.key, 
    required this.title,
    required this.description,
    required this.onReload,
  });
  
  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          onReload;
        },

        borderRadius: BorderRadius.circular(5),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(5),
            ),
            20.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  50.ph,
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                    10.ph,
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
}

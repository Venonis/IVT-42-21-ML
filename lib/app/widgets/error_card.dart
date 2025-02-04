// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_application_1/app/app.dart';
part of 'widgets.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key, required title, description, onReload,
  });
  
  @override
  Widget build(BuildContext context) {
      return InkWell(
        // onTap: () {
        //   // для следующей лабораторной работы
        //   context.go('/home/article/1');
        // },

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
                  Text(
                    '$this.title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                    5.ph,
                  Text(
                    'Tap to enter second page',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
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

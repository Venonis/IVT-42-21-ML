// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_application_1/app/app.dart';
part of 'widgets.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key, required this.article, required this.id,
  });

  final int id;
  final Article article;
  
  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          // для следующей лабораторной работы
          context.go('/home/article/$id');
        },

        borderRadius: BorderRadius.circular(5),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
            width: 100,
            height: 100,
            'assets/images/test_image.jpg',
            //article.imageUrl,
            fit: BoxFit.cover,
            ),
            ),
            20.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                    5.ph,
                  Text(
                    article.description,
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
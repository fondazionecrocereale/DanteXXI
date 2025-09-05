import 'package:flutter/material.dart';
import '../../../domain/entities/article.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;
  final Function(Article) onArticleTap;

  const ArticleList({
    super.key,
    required this.articles,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay artículos disponibles',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return _ArticleCard(
          article: article,
          onTap: () => onArticleTap(article),
        );
      },
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const _ArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Article Cover
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(article.coverImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Article Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.excerpt,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Category Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(
                              article.category,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getCategoryName(article.category),
                            style: TextStyle(
                              color: _getCategoryColor(article.category),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Read Time
                        Icon(
                          Icons.access_time,
                          color: Colors.grey[500],
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${article.readTime} min',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                        const Spacer(),
                        // Views
                        Icon(
                          Icons.visibility,
                          color: Colors.grey[500],
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${article.views}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.grammar:
        return Colors.blue;
      case ArticleCategory.vocabulary:
        return Colors.green;
      case ArticleCategory.culture:
        return Colors.purple;
      case ArticleCategory.pronunciation:
        return Colors.orange;
      case ArticleCategory.tips:
        return Colors.teal;
      case ArticleCategory.news:
        return Colors.red;
      case ArticleCategory.lifestyle:
        return Colors.pink;
      case ArticleCategory.travel:
        return Colors.indigo;
      case ArticleCategory.business:
        return Colors.brown;
      case ArticleCategory.other:
        return Colors.grey;
    }
  }

  String _getCategoryName(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.grammar:
        return 'Gramática';
      case ArticleCategory.vocabulary:
        return 'Vocabulario';
      case ArticleCategory.culture:
        return 'Cultura';
      case ArticleCategory.pronunciation:
        return 'Pronunciación';
      case ArticleCategory.tips:
        return 'Consejos';
      case ArticleCategory.news:
        return 'Noticias';
      case ArticleCategory.lifestyle:
        return 'Estilo de Vida';
      case ArticleCategory.travel:
        return 'Viajes';
      case ArticleCategory.business:
        return 'Negocios';
      case ArticleCategory.other:
        return 'Otros';
    }
  }
}

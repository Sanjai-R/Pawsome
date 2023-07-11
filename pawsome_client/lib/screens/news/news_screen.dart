import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/news_provider.dart';
import 'package:pawsome_client/screens/news/news_detail.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<NewsProvider>().getNews();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final newsProvider = context.read<NewsProvider>();
      if (!newsProvider.isLoading && !newsProvider.isLastPage) {
        newsProvider.getMoreNews();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          final news = newsProvider.news.where(
                (element) => element['urlToImage'] != null && !element['urlToImage'].toString().contains('webp') ,
          ).toList();


          if (newsProvider.isLoading ) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: ListView.builder(
                itemCount: news.length + 1, // Add 1 for the loading indicator
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                 if(index < news.length ){
                   return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetail(news: news[index]),
                          ),
                        );
                      },
                     child: Container(
                       padding: const EdgeInsets.all(8.0),
                       margin: const EdgeInsets.symmetric(vertical: 5.0),
                       decoration: BoxDecoration(
                         boxShadow: boxShadow,
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(8.0),
                         border: Border.all(color: Colors.grey.shade300),
                       ),
                       child: Row(
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(8.0),
                             child: Image.network(
                               news[index]['urlToImage'] ??
                                   'https://via.placeholder.com/150',
                               height: 100,
                               width: 100,
                               fit: BoxFit.cover,
                             ),
                           ),
                           const SizedBox(width: 10),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                                   children: [
                                     Expanded(
                                       child: Text(
                                         news[index]['title'].toString(),
                                         style: const TextStyle(
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold,
                                         ),
                                         maxLines: 2,
                                       ),
                                     ),
                                   ],
                                 ),
                                 const SizedBox(height: 5),
                                 Text(
                                   news[index]['description'].toString(),
                                   maxLines: 2,
                                   style: const TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.w400,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 }
                 else if(newsProvider.isLastPage){
                   return Center(
                     child: Text('No more news'),
                   );
                 }
                 else{
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                  // return NewsContainer(news: news[index]
                },
              ),
            );
          }
        },
      ),
    );
  }
}

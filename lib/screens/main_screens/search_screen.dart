import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController _searchEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SEARCH",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey[300]!)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        controller: _searchEditingController,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.white70,
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          hintText: 'Search for items...',
                          hintStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: FlutterCarousel.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, index1, index2) {
                          List<String> hints = [
                            "Search for apples...",
                            "Find fresh fish...",
                            "Check out the best meats...",
                            "Discover exotic spices...",
                            "Shop for dairy products..."
                          ];
                          return Center(
                            child: Text(
                              hints[index1],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        options: FlutterCarouselOptions(
                          scrollDirection: Axis.vertical,
                          height: 50,
                          showIndicator: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(milliseconds: 2500),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  "Suggested",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (ctx, index) {
                    List<Map<String, String>> sampleItems = [
                      {
                        "image":
                            "https://media.istockphoto.com/id/93456470/photo/two-raw-chicken-breast-on-white-backdrop.webp?a=1&b=1&s=612x612&w=0&k=20&c=xY6GFYmyWKkfAh1hWyE9EWuLRhJsQ4rudnWRF_vyBc8=",
                        "title": "Chicken breast",
                      },
                      {
                        "image":
                            "https://media.istockphoto.com/id/171359079/photo/prime-boneless-hip-sirloin-steak.webp?a=1&b=1&s=612x612&w=0&k=20&c=BH8UHMLunlNkewtynl3CaijxBvhfzAgvrw44DLPta2c=",
                        "title": "Boneless beef",
                      },
                      {
                        "image":
                            "https://media.istockphoto.com/id/1130266218/photo/nice.webp?a=1&b=1&s=612x612&w=0&k=20&c=_m_eF9zZYP7zkx_4ULPzSpOhAXs86jylhC82ose1xgI=",
                        "title": "Tuna",
                      },
                      {
                        "image":
                            "https://media.istockphoto.com/id/1345303123/photo/raw-squid-fresh-seafood-isolated-on-white-background-single-object.webp?a=1&b=1&s=612x612&w=0&k=20&c=H-Zxaa6YLJwmpk_adUfyss0O79-Uo72AQq-LnZuHxTw=",
                        "title": "Squid",
                      },
                      {
                        "image":
                            "https://media.istockphoto.com/id/157641208/photo/a-large-pink-salmon-fillet-isolated-on-a-white-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=ClLUKlX5Iv5nyuWidfpXUv-HsEPfWDjjL8_ciKhvKY4=",
                        "title": "salmon",
                      },
                    ];
                    return Container(
                      width: 250,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 20.0 : 10.0,
                        right: index == 2 ? 20.0 : 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: Colors.grey[300]!)),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(50),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                sampleItems[index]["image"] ?? "",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                sampleItems[index]["title"] ?? "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Text(
                  "Recent Searches",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (ctx, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).primaryColor.withAlpha(50),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 10.0),
                      leading: const Icon(Icons.history),
                      title: Text(
                        "Item $index",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _searchEditingController.text = "item $index";
                        },
                        icon: Transform.flip(
                          flipX: true,
                          child: const Icon(Icons.arrow_outward),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

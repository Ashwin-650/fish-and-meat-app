import 'package:fish_and_meat_app/constants/appcolor.dart';
import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              color: Appcolor.appbargroundColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey[300]!)),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withAlpha(50),
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
    );
  }
}

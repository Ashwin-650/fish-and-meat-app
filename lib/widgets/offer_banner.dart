import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:flutter/material.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20)),
      height: 200,
      child: Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: 'Chicken Boneless'
                    .extenTextStyle(fontWeight: FontWeight.bold, fontsize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: 'Discount 25%'.extenTextStyle(
                  fontsize: 20,
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          const Color(0xFF3E7C78).withAlpha(150))),
                  onPressed: () {},
                  child: 'Order Now'.extenTextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white))
            ],
          ),
          SizedBox(
            child: Image.network(
              height: 180,
              width: 180,
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTB6f6qKHdRPrQ_YNF9hMdNt-__R9kDS2tX_KArIDK5pkmS9ixGLUHt1_juzwt55G_aEoE&usqp=CAU',
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Carousel(
      dotBgColor: Colors.transparent,
      indicatorBgPadding: 5.0,
      dotIncreasedColor: AppColors.primaryMediumColor,
      dotColor: Colors.grey[400],
      dotPosition: DotPosition.bottomRight,
      images: [
        Image.asset(Res.baner1, fit: BoxFit.fill),
        Image.asset(
          Res.baner2,
          fit: BoxFit.fill,
        ),
        Image.asset(
          Res.baner3,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}

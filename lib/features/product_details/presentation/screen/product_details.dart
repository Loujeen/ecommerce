import 'package:flutter/material.dart';
import 'package:ecommerce/domain/entities/ProductResponseEntity.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';
import '../widgets/product_description.dart';
import '../widgets/product_label.dart';
import '../widgets/product_rating.dart';

class ProductDetails extends StatelessWidget {
  ProductEntity product;

  ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorManager.primaryDark),
        title: Text(
          'Product Details',
          style: getMediumStyle(color: ColorManager.appBarTitleColor)
              .copyWith(fontSize: 20.sp),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(IconsAssets.icSearch),
                color: ColorManager.primary,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: ColorManager.primary,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: ColorManager.primary)),
              child: ImageSlideshow(
                initialPage: 0,
                indicatorColor: ColorManager.primaryDark,
                indicatorBackgroundColor: ColorManager.white,
                indicatorBottomPadding: 20.h,
                autoPlayInterval: 3000,
                isLoop: true,
                children: product.images!
                    .map((url) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                    width: 210.w,
                    height: 210.h,
                  ),
                ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            ProductLabel(
                productName: product.title ?? '',
                productPrice: 'EGP ${product.price}'),
            SizedBox(
              height: 16.h,
            ),
            ProductRating(
                productBuyers: '${product.sold} ',
                productRating: product.ratingsAverage.toString()),
            SizedBox(
              height: 16.h,
            ),
            ProductDescription(productDescription: product.description ?? ""),
            SizedBox(
              height: 48.h,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Total price',
                      style: getMediumStyle(
                          color: ColorManager.primary.withOpacity(.6))
                          .copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text('EGP ${product.price}',
                        style:
                        getMediumStyle(color: ColorManager.appBarTitleColor)
                            .copyWith(fontSize: 18.sp))
                  ],
                ),
                SizedBox(
                  width: 33.w,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    label: 'Add to cart',
                    onTap: () {},
                    prefixIcon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: ColorManager.white,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
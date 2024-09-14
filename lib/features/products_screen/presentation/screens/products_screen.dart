import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/core/resources/color_manager.dart';
import 'package:ecommerce/core/widget/dialog_utils.dart';
import 'package:ecommerce/features/product_details/presentation/screen/product_details.dart';
import 'package:ecommerce/features/products_screen/presentation/cubit/product_screen_view_model.dart';
import 'package:ecommerce/features/products_screen/presentation/cubit/product_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/routes_manager/routes.dart';
import '../widgets/product_item_widget.dart';

class ProductsScreen extends StatelessWidget {
  // ProductScreenViewModel viewModel = getIt<ProductScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductScreenViewModel, ProductStates>(
      bloc: ProductScreenViewModel.get(context)..getAllProducts(),
      listener: (context, state) {
        if (state is AddToCartErrorState) {
          DialogUtils.showMessage(
              context: context, message: state.failures.errorMessage);
        } else if (state is ProductErrorState) {
          DialogUtils.showMessage(
              context: context, message: state.failures.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: true,
              title: SvgPicture.asset(
                SvgAssets.routeLogo,
                height: 25.h,
                width: 25.w,
                colorFilter: const ColorFilter.mode(
                    ColorManager.textColor, BlendMode.srcIn),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size(AppSize.s100, AppSize.s60),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: ColorManager.primary,
                            style: getRegularStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: AppMargin.m12.w,
                                  vertical: AppMargin.m8.h),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10000),
                                  borderSide: BorderSide(
                                      width: AppSize.s1,
                                      color: ColorManager.primary)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10000),
                                  borderSide: BorderSide(
                                      width: AppSize.s1,
                                      color: ColorManager.primary)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10000),
                                  borderSide: BorderSide(
                                      width: AppSize.s1,
                                      color: ColorManager.primary)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10000),
                                  borderSide: BorderSide(
                                      width: AppSize.s1,
                                      color: ColorManager.primary)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10000),
                                  borderSide: BorderSide(
                                      width: AppSize.s1,
                                      color: ColorManager.error)),
                              prefixIcon: ImageIcon(
                                AssetImage(IconsAssets.icSearch),
                                color: ColorManager.primary,
                              ),
                              hintText: "what do you search for?",
                              hintStyle: getRegularStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.cartRoute),
                            icon: Badge(
                              label: Text(ProductScreenViewModel.get(context)
                                  .numOfCartItems
                                  .toString()),
                              child: ImageIcon(
                                AssetImage(IconsAssets.icCart),
                                color: ColorManager.primary,
                              ),
                            ))
                      ],
                    ),
                  )),
              // leading: const SizedBox.shrink(),
            ),
            body: ProductScreenViewModel.get(context).productsList.isEmpty
                ? Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            )
                : Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: GridView.builder(
                itemCount: ProductScreenViewModel.get(context)
                    .productsList
                    .length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: 6 / 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                product:
                                ProductScreenViewModel.get(context)
                                    .productsList[index])));
                      },
                      child: ProductItemWidget(
                          product: ProductScreenViewModel.get(context)
                              .productsList[index]));
                },
                scrollDirection: Axis.vertical,
              ),
            ));
      },
    );
  }
}
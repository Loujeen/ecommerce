import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/features/cart/cubit/cart_screen_view_model.dart';
import 'package:ecommerce/features/cart/cubit/cart_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/styles_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/total_price_and_checkout_botton.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartScreenViewModel, CartStates>(
      bloc: CartScreenViewModel.get(context)..getCart(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: ColorManager.primaryDark),
            title: Text(
              'Cart',
              style:
              getMediumStyle(fontSize: 20, color: ColorManager.textColor),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(
                    IconsAssets.icSearch,
                  ),
                  color: ColorManager.primary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage(IconsAssets.icCart),
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
          body: state is GetCartSuccessState
              ? Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: [
                Expanded(
                  // the list of cart items ===============
                  child: ListView.separated(
                    itemBuilder: (context, index) => CartItemWidget(
                      cartEntity: state
                          .getCartResponseEntity.data!.products![index],
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: AppSize.s12.h),
                    itemCount: state
                        .getCartResponseEntity.data!.products!.length,
                  ),
                ),
                // the total price and checkout button========
                TotalPriceAndCheckoutBotton(
                  totalPrice: state
                      .getCartResponseEntity.data!.totalCartPrice!
                      .toInt(),
                  checkoutButtonOnTap: () {},
                ),
                SizedBox(height: 10.h),
              ],
            ),
          )
              : Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              )),
        );
      },
    );
  }
}
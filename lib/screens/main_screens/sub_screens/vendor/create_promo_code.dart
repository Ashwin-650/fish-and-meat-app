import 'package:fish_and_meat_app/extentions/text_extention.dart';
import 'package:fish_and_meat_app/widgets/common_button.dart';
import 'package:fish_and_meat_app/widgets/custom_text_field.dart';
import 'package:fish_and_meat_app/widgets/custom_date_field_widget.dart';
import 'package:flutter/material.dart';

class CreatePromoCode extends StatelessWidget {
  CreatePromoCode({super.key});

  final TextEditingController _discountPercentController =
      TextEditingController();
  final TextEditingController _minimumAmountController =
      TextEditingController();
  final DateTime expiryDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add promo code".extenTextStyle(),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              CustomTextField(
                label: "Discount (%)",
                hint: "20",
                textController: _discountPercentController,
                isNumberField: true,
              ),
              CustomTextField(
                label: "Minimum discount amount (\$)",
                hint: "200",
                textController: _minimumAmountController,
                isNumberField: true,
              ),
              CustomDateFieldWidget(
                ontap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: expiryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                deliveryDate: DateTime.now(),
              ),
              CommonButton(onPress: () {}, buttonText: "Create")
            ],
          ),
        ),
      ),
    );
  }
}

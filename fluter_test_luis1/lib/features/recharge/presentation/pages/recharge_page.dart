import 'package:flutter/material.dart';
import 'package:fluter_test_luis1/core/assets.dart';
import 'package:flutter/rendering.dart';
import 'package:fluter_test_luis1/features/recharge/presentation/pages/confirmation_page.dart';
import 'package:provider/provider.dart';
import 'package:fluter_test_luis1/features/recharge/presentation/state/recharge_provider.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  String selectedNetwork = "";
  String selectedAmount = "";
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _circleIcon(
            icon: Icons.arrow_back_ios_new,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),

        title: const Text(
          "Recharge",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _notificationIcon(),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Add Mobile Number", 
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
            ),

            const Text("Enter recipient mobile number"),
            const SizedBox(height: 5),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                filled: true, 
                fillColor: Colors.grey[200], 
                hintText: "Mobile number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Select Network",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _networkItem("Tigo", Assets.tigoIcon),
                  _networkItem("Claro", Assets.claroIcon),
                  _networkItem("Movistar", Assets.movistarIcon),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text("Enter Amount"),
            const SizedBox(height: 5),

            TextField(
              controller: _amountController,
              readOnly: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006FFD),
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Q0.00",
                filled: true,
                fillColor: Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Color(0xFF006FFD),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _amountButton("Q50"),
                _amountButton("Q100"),
                _amountButton("Q150"),
              ],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF006FFD))),
                onPressed: () {
                  if (_phoneController.text.isEmpty) {
                    _showError("Ingrese un número");
                    return;
                  }

                  if (selectedNetwork.isEmpty) {
                    _showError("Seleccione una telefonía");
                    return;
                  }

                  if (selectedAmount.isEmpty) {
                    _showError("Seleccione un monto");
                    return;
                  }

                  final provider = context.read<RechargeProvider>();
                  provider.setPhone(_phoneController.text);
                  provider.setNetwork(selectedNetwork);
                  provider.setAmount(selectedAmount);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmationPage(
                        // phone: _phoneController.text,
                        // network: selectedNetwork,
                        // amount: selectedAmount,
                      ),
                    ),
                  );
                },
                child: const Text("Continue",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _networkItem(String name, String imagePath) {
    final bool isSelected = selectedNetwork == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNetwork = name;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? Color(0xFF006FFD) : Colors.grey.shade300,
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 40),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Color(0xFF006FFD) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountButton(String amount) {
    final bool isSelected = selectedAmount == amount;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAmount = amount;
          _amountController.text = amount;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF006FFD) : Colors.grey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF006FFD) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Color(0xFF006FFD) : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleIcon({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(12),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  Widget _notificationIcon() {
    return Stack(
      children: [
        _circleIcon(
          icon: Icons.notifications_none,
          onTap: () {},
        ),

        Positioned(
          right: 4,
          top: 4,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

}
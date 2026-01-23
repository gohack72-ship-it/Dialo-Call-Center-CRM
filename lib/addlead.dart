import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewLeadPage extends StatelessWidget {
  const NewLeadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'New Lead',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      
                    
                    const SizedBox(height: 12),
                    // _label('Full Name'),
                    // _input('Enter Name'),
                    // _label("place"),
                    // _input("Enter Place"),
                    // _label("Phone"),
                    // _input("Enter Number",
                    // Keyboard:TextInputType.phone),
                    const SizedBox(height: 20),
                    const Text('Lead Details',
                    style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

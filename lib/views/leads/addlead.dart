import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants/app_textstyle.dart';
import '../../providers/leadProvider.dart';

class NewLeadPage extends StatefulWidget {
  const NewLeadPage({super.key});

  @override
  State<NewLeadPage> createState() => _NewLeadPageState();
}

class _NewLeadPageState extends State<NewLeadPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // ✅ LOAD DROPDOWN DATA
    Future.microtask(() {
      context.read<LeadProvider>().fetchAdditionalLeadDetails();
      context.read<LeadProvider>().getLeadStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 12),
                    Text(
                      'New Lead',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 20),

                        _label('Full Name'),
                        _input(
                          'Enter Name',
                          context.read<LeadProvider>().nameController,
                        ),

                        _label("Place"),
                        _input(
                          "Enter Place",
                          context.read<LeadProvider>().placeController,
                        ),

                        _label("Email"),
                        _input(
                          "Enter Email",
                          context.read<LeadProvider>().emailController,
                        ),

                        _label("Phone"),
                        _phoneField(),

                        _label("Source"),
                        _input(
                          "Source",
                          context.read<LeadProvider>().sourceController,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Lead Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// ✅ STATUS DROPDOWN
                        Consumer<LeadProvider>(
                          builder: (context, status, child) {
                            if (status.statusList.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return _dropdown(
                              hint: "Status",
                              items: status.statusList,
                              value: status.selectedStatus,
                              onChanged: (st) {
                                status.changeStatus(st!);
                              },
                            );
                          },
                        ),

                        Consumer<LeadProvider>(

                          builder: (context, val, child) {
                            if (val.additionalLeadDetailsList.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Column(
                              children: val.additionalLeadDetailsList.map((
                                item,
                              ) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _label(item.title),

                                    item.sub != null && item.sub.isNotEmpty
                                        ? _dropdown(
                                      hint: item.title,
                                      items: item.sub,
                                      value: null,
                                      onChanged: (v) {
                                        val.selectedLeadsFilters.removeWhere(
                                                (e) => e.containsKey(item.title));

                                        val.selectedLeadsFilters.add({
                                          item.title: v,
                                        });

                                        print("DROPDOWN: ${val.selectedLeadsFilters}");

                                      },
                                    )
                                        : Builder(

                                      builder: (context) {
                                        final controller = TextEditingController();

                                        controller.addListener(() {
                                          val.selectedLeadsFilters.removeWhere(
                                                  (e) => e.containsKey(item.title));

                                          val.selectedLeadsFilters.add({
                                            item.title: controller.text,
                                          });

                                          print("TEXT: ${val.selectedLeadsFilters}");
                                        });

                                        return _input(
                                          "Enter ${item.title}",
                                          controller,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }).toList(),
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        /// ✅ CREATE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LeadProvider>().addNewLead();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Lead Created Successfully'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3F5FBF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Create Lead',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 LABEL
  static Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  /// 🔹 INPUT
  Widget _input(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        style: AppTextstyle.normalText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hint';
          }
          return null;
        },
      ),
    );
  }

  /// 🔹 PHONE FIELD
  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        style: AppTextstyle.normalText,
        controller: context.read<LeadProvider>().phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: InputDecoration(
          hintText: 'Enter Phone Number',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter phone number';
          }
          if (value.length != 10) {
            return 'Phone number must be 10 digits';
          }
          return null;
        },
      ),
    );
  }

  /// 🔹 DROPDOWN
  Widget _dropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint),
        items: items
            .map(
              (item) =>
                  DropdownMenuItem<String>(value: item, child: Text(item)),
            )
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $hint' : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

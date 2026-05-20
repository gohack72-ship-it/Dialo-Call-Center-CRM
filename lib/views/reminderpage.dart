import 'package:dialo/constants/app_colors.dart';
import 'package:dialo/constants/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/leadProvider.dart';

class ReminderPage extends StatefulWidget {
  final String leadId;

  const ReminderPage({super.key, required this.leadId});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<LeadProvider>();
      provider.getCallStatusList();
      provider.getLeadStatus();
    });
  }

  Future<void> _triggerImmediateScheduling(BuildContext context) async {
    final provider = context.read<LeadProvider>();
    await provider.pickDate(context);
    if (provider.selectedDate != null && context.mounted) {
      await provider.pickTime(context);
    }
  }

  void _validateAndSubmit(BuildContext context) {
    final provider = context.read<LeadProvider>();

    // Debugging tools to see exactly what your app sees in the terminal
    debugPrint("=== VALIDATION DEBUG LOG ===");
    debugPrint("Selected Call Status: '${provider.selectedCallStatus}'");
    debugPrint("Selected Lead Stage: '${provider.selectedLeadStage}'");

    // 1. Validate Call Status Choice
    if (provider.selectedCallStatus == null || provider.selectedCallStatus!.trim().isEmpty) {
      _showErrorSnackBar(context, "Please select a valid Call Status");
      return;
    }

    // 2. Validate Lead Stage Choice
    if (provider.selectedLeadStage == null || provider.selectedLeadStage!.trim().isEmpty) {
      _showErrorSnackBar(context, "Please select a Lead Stage");
      return;
    }

    // Normalize selected value strings to strip spaces or typos
    String normalizedSelectedStage = provider.selectedLeadStage!.toLowerCase().replaceAll(" ", "").replaceAll("_", "");
    debugPrint("Normalized Selected Stage: '$normalizedSelectedStage'");

    // 3. Conditional Validation for Schedule Window
    if (normalizedSelectedStage == "followup") {
      if (provider.selectedDate == null) {
        _showErrorSnackBar(context, "Please choose a custom date for your follow-up");
        return;
      }
      if (provider.selectedTime == null) {
        _showErrorSnackBar(context, "Please choose a target time for your follow-up");
        return;
      }
    }

    // 4. Validate Reminder Note Body
    if (provider.followUpNoteController.text.trim().isEmpty) {
      _showErrorSnackBar(context, "Please add a brief reminder note for context");
      return;
    }

    // Execution block
    provider.addFollowUp(widget.leadId);
    provider.clearReminderForm();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 22),
            SizedBox(width: 12),
            Text("Configuration Successfully Committed", style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: Colors.tealAccent[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );

    Navigator.pop(context);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Expanded(child: Text(message, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          ],
        ),
        backgroundColor: const Color(0xFFFF3B30),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0C) : const Color(0xFFF8F9FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF13131A) : Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded, size: 28, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
            "Schedule Action",
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.8
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF13131A) : Colors.white,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.4 : 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ACTION PANEL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.themeColor, letterSpacing: 2)),
                  const SizedBox(height: 6),
                  Text("Update Lead Disposition", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Theme.of(context).textTheme.bodyLarge?.color)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel("CALLED DATE"),
                  TextFormField(
                    readOnly: true,
                    controller: context.watch<LeadProvider>().calledDateController,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    decoration: _inputDecoration(isDark, prefixIcon: Icons.calendar_today_rounded),
                  ),
                  const SizedBox(height: 24),

                  _buildSectionLabel("CALL OUTCOME / DISPOSITION"),
                  Consumer<LeadProvider>(
                    builder: (context, val, child) {
                      return DropdownButtonFormField<String>(
                        value: val.selectedCallStatus,
                        dropdownColor: isDark ? const Color(0xFF161622) : Colors.white,
                        icon: const Icon(Icons.expand_more_rounded, color: Colors.grey),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w600, fontSize: 15),
                        decoration: _inputDecoration(isDark, prefixIcon: Icons.phone_callback_rounded),
                        hint: Text("Select call outcome status...", style: TextStyle(color: Colors.grey[500], fontSize: 14, fontWeight: FontWeight.w400)),
                        items: val.callStatusList.map((status) {
                          return DropdownMenuItem<String>(value: status, child: Text(status));
                        }).toList(),
                        onChanged: (value) {
                          val.selectedCallStatus = value;
                          val.notifyListeners();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildSectionLabel("FUNNEL STAGE SEGMENTATION"),
                  Consumer<LeadProvider>(
                    builder: (context, valu, child) {
                      return DropdownButtonFormField<String>(
                        value: valu.statusList.contains(valu.selectedLeadStage) ? valu.selectedLeadStage : null,
                        dropdownColor: isDark ? const Color(0xFF161622) : Colors.white,
                        icon: const Icon(Icons.expand_more_rounded, color: Colors.grey),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w600, fontSize: 15),
                        decoration: _inputDecoration(isDark, prefixIcon: Icons.filter_list_rounded),
                        hint: Text("Update client stage segment...", style: TextStyle(color: Colors.grey[500], fontSize: 14, fontWeight: FontWeight.w400)),
                        items: valu.statusList.map((status) {
                          return DropdownMenuItem<String>(value: status, child: Text(status));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            // 🔥 FIX: Explicitly assign the value to your state manager variable right here
                            valu.selectedLeadStage = val;
                            valu.changeLeadStage(val);

                            String normalized = val.toLowerCase().replaceAll(" ", "").replaceAll("_", "");
                            if (normalized == "followup") {
                              _triggerImmediateScheduling(context);
                            }
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  Consumer<LeadProvider>(
                    builder: (context, valu, child) {
                      String normalizedStage = (valu.selectedLeadStage ?? "").toLowerCase().replaceAll(" ", "").replaceAll("_", "");
                      if (normalizedStage != "followup") return const SizedBox();

                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: _boxDecoration(isDark, activeHighlight: true),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.alarm_add_rounded, size: 20, color: AppColors.themeColor),
                                const SizedBox(width: 10),
                                Text("Scheduled Window", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Theme.of(context).textTheme.bodyLarge?.color)),
                              ],
                            ),
                            const SizedBox(height: 18),

                            _buildPickerActionTile(
                              context,
                              icon: Icons.calendar_today_rounded,
                              title: "Target Follow Date",
                              child: Consumer<LeadProvider>(
                                builder: (context, val, child) => Text(
                                  val.selectedDate == null
                                      ? "No Date Chosen"
                                      : "${val.selectedDate!.day.toString().padLeft(2, '0')} MMM, ${val.selectedDate!.year}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: val.selectedDate == null ? Colors.grey : AppColors.themeColor),
                                ),
                              ),
                              onTap: () => context.read<LeadProvider>().pickDate(context),
                            ),
                            const SizedBox(height: 12),

                            _buildPickerActionTile(
                              context,
                              icon: Icons.schedule_rounded,
                              title: "Target Follow Time",
                              child: Consumer<LeadProvider>(
                                builder: (context, val, child) => Text(
                                  val.selectedTime == null ? "No Time Chosen" : val.selectedTime!.format(context),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: val.selectedTime == null ? Colors.grey : AppColors.themeColor),
                                ),
                              ),
                              onTap: () => context.read<LeadProvider>().pickTime(context),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildSectionLabel("INTERNAL REMINDER SUMMARY MEMO"),
                  Container(
                    decoration: _boxDecoration(isDark),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Consumer<LeadProvider>(
                      builder: (context, val, child) {
                        return TextField(
                          controller: val.followUpNoteController,
                          maxLines: 4,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
                          decoration: InputDecoration(
                            hintText: "Enter executive notes or next steps detailing this interaction pipeline...",
                            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 44),

                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [AppColors.themeColor, Color(0xFF6366F1)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.themeColor.withOpacity(0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => _validateAndSubmit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_clock_outlined, size: 20, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            "Commit & Save Reminder",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey[400], letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildPickerActionTile(BuildContext context, {required IconData icon, required String title, required Widget child, required VoidCallback onTap}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF13131A) : const Color(0xFFF1F3F9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[500]),
            const SizedBox(width: 14),
            Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w600))),
            child,
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(bool isDark, {required IconData prefixIcon}) {
    return InputDecoration(
      fillColor: isDark ? const Color(0xFF13131A) : Colors.white,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Icon(prefixIcon, size: 20, color: AppColors.themeColor.withOpacity(0.8)),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: isDark ? const Color(0xFF222230) : Colors.grey.shade200, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.themeColor, width: 2),
      ),
    );
  }

  BoxDecoration _boxDecoration(bool isDark, {bool activeHighlight = false}) {
    return BoxDecoration(
      color: isDark ? const Color(0xFF13131A) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.03),
          blurRadius: 16,
          offset: const Offset(0, 6),
        )
      ],
      border: activeHighlight
          ? Border.all(color: AppColors.themeColor.withOpacity(0.4), width: 1.5)
          : Border.all(color: isDark ? const Color(0xFF222230) : Colors.grey.shade200, width: 1.5),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditTask extends StatelessWidget {
  const EditTask({super.key});

  static const Color textColor = Color(0xFF536477);
  static const Color lightGrey = Color(0xFFF0F3F8);
  static const Color blueColor = Color(0xFF4CB8F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 21,
          ),
        ),
        title: const Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.export_1,
              color: Colors.black87,
              size: 23,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 25, 24, 20),
                children: [
                  // Task title and description
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                          color: lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.title,
                          color: textColor,
                          size: 27,
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task Title',
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                              ),
                            ),
                            SizedBox(height: 9),
                            Text(
                              'Do Math Homework',
                              style: TextStyle(
                                fontSize: 21,
                                color: Color(0xFF1D2939),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Do chapter 2 to 5 for next week.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8995A5),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Iconsax.edit_2,
                        color: textColor,
                        size: 23,
                      ),
                    ],
                  ),

                  const SizedBox(height: 52),

                  // Task time
                  _detailRow(
                    icon: Iconsax.clock,
                    title: 'Task Time',
                    value: 'Today At 16:45',
                  ),

                  const SizedBox(height: 22),

                  // Task category
                  _detailRow(
                    icon: Iconsax.tag,
                    title: 'Task Category',
                    value: 'University',
                    valueColor: const Color(0xFF1599DC),
                    valueBackground: const Color(0xFFE0F4FF),
                    valueIcon: Iconsax.book_1,
                  ),

                  const SizedBox(height: 22),

                  // Task priority
                  _detailRow(
                    icon: Iconsax.flag,
                    title: 'Task Priority',
                    value: 'Low',
                  ),

                  const SizedBox(height: 22),

                  // Subtask
                  _detailRow(
                    icon: Iconsax.hierarchy,
                    title: 'Sub-Task',
                    value: 'Add Sub Task',
                    valueIcon: Iconsax.task,
                  ),

                  const SizedBox(height: 28),

                  // Delete task
                  Row(
                    children: [
                      const Icon(
                        Iconsax.trash,
                        color: Color(0xFFFF4567),
                        size: 23,
                      ),
                      const SizedBox(width: 18),
                      const Text(
                        'Delete Task',
                        style: TextStyle(
                          color: Color(0xFFFF4567),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Save button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailRow({
    required IconData icon,
    required String title,
    required String value,
    IconData? valueIcon,
    Color valueColor = textColor,
    Color valueBackground = lightGrey,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 25,
          color: textColor,
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Container(
          constraints: const BoxConstraints(
            minHeight: 48,
            maxWidth: 190,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: valueBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (valueIcon != null) ...[
                Icon(
                  valueIcon,
                  color: valueColor,
                  size: 21,
                ),
                const SizedBox(width: 10),
              ],

              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: valueColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.chevron_right,
                size: 20,
                color: textColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


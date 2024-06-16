import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class BirthdayInput extends StatefulWidget {
  const BirthdayInput({super.key});

  @override
  State<BirthdayInput> createState() => BirthdayInputState();
}

class BirthdayInputState extends State<BirthdayInput> {
  DateTime date = DateTime(2000, 1, 1);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Дата рождения',
                  style: TextStyle(
                    color: Colors.black.withAlpha(80),
                    fontSize: 10,
                  ),
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(date),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                var datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  titleText: 'Укажите дату рождения',
                  initialDate: date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  dateFormat: "dd-MMMM-yyyy",
                  locale: DateTimePickerLocale.ru,
                  looping: true,
                );
                setState(() {
                  date = datePicked ?? date;
                });
                if (context.mounted) {
                  context
                      .read<RegisterCubit>()
                      .birthdayChanged(datePicked ?? date);
                }
              },
              icon: const Icon(Icons.calendar_month))
        ]),
        const Divider(
          thickness: 1.1,
          color: Colors.grey,
        )
      ],
    );
  }
}

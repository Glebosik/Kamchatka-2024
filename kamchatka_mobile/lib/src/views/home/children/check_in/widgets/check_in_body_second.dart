import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/models/oopt.dart';

class CheckInBodySecond extends StatefulWidget {
  const CheckInBodySecond({
    super.key,
    required this.selectedOopt,
    required this.selectedType,
  });
  final Oopt selectedOopt;
  final String selectedType;

  @override
  State<CheckInBodySecond> createState() => _CheckInBodySecondState();
}

class _CheckInBodySecondState extends State<CheckInBodySecond> {
  DateTime? _selectedDate;
  String? _selectedEmail;
  String? _selectedPhone;
  String? _selectedFormat;
  String? _selectedGoal;
  String? _selectedMedia;

  final List<String> formats = [
    'Многодневный тур (от 1 ночевки и более)',
    'Дневная экскурсия (без ночевки)',
  ];
  final List<String> media = [
    'Проведение профессиональной кино-, фото-и видеосъемки со стационарным оборудованием',
    'С использованием БПЛА',
    'Без съемки',
  ];

  @override
  Widget build(BuildContext context) {
    final dataRepository = context.read<DataRepository>();
    final user = dataRepository.getUser();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Разрешение на посещение',
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: IgnorePointer(
              child: Assets.auth.background.svg(
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  stringRow(width, context, 'Фамилия', user!.nameSecond,
                      Assets.icons.applicationFormName.svg(width: 30)),
                  stringRow(width, context, 'Имя', user.nameFirst,
                      Assets.icons.applicationFormName.svg(width: 30)),
                  stringRow(width, context, 'Отчество', user.nameThird,
                      Assets.icons.applicationFormName.svg(width: 30)),
                  const SizedBox(height: 24),
                  birthRow(width, context, user.birthday),
                  stringRow(width, context, 'Гражданство', user.nationality,
                      Assets.icons.applicationFormGov.svg(width: 30)),
                  stringRow(width, context, 'Регион регистрации', user.region,
                      Assets.icons.applicationFormGov.svg(width: 30)),
                  stringRow(
                      width,
                      context,
                      'Пол',
                      user.gender == 'm' ? 'Мужской' : 'Женский',
                      Assets.icons.applicationFormName.svg(width: 30)),
                  stringRow(
                      width,
                      context,
                      'Серия и номер паспорта',
                      '${user.passport.substring(0, 4)} ${user.passport.substring(4, user.passport.length)}',
                      Assets.icons.applicationFormPass.svg(width: 30)),
                  const SizedBox(height: 24),
                  datePicker(width, context),
                  dropdownFormatInput(
                    width,
                    context,
                    'Формат посещения',
                    Assets.icons.applicationFormDate.svg(width: 30),
                    formats,
                    _selectedFormat,
                  ),
                  dropdownMediaInput(
                    width,
                    context,
                    'Кино-, фото- и видеосъемка',
                    Assets.icons.applicationFormMedia.svg(width: 30),
                    media,
                    _selectedMedia,
                  ),
                  const SizedBox(height: 24),
                  goalInput(width, context,
                      Assets.icons.applicationFormGoal.svg(width: 30)),
                  emailInput(width, context,
                      Assets.icons.applicationFormMail.svg(width: 30)),
                  numberInput(width, context,
                      Assets.icons.applicationFormPhone.svg(width: 30)),
                  const SizedBox(height: 32),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          color:
                              isValid() ? ColorName.primary : Colors.black54),
                    ),
                    onPressed: !isValid()
                        ? null
                        : () async {
                            await dataRepository.sendApplication(
                              email: _selectedEmail!,
                              arrive: _selectedDate!,
                              format: _selectedFormat!,
                              aim: _selectedGoal!,
                              media: _selectedMedia!,
                              ooptName: widget.selectedOopt.name,
                            );
                            await showDialog(
                              barrierDismissible: false,
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                Future.delayed(const Duration(seconds: 3), () {
                                  final nav = Navigator.of(context);
                                  nav.pop(true);
                                  nav.pop(true);
                                  nav.pop(true);
                                });
                                return AlertDialog(
                                  content: SizedBox(
                                    height: 175,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Assets.icons.statusApproved
                                            .svg(height: 64),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Благодарим за ваше обращение!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Заявка на посещение будет рассмотрена в ближайшее время.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                                  ),
                                );
                              },
                            );
                          },
                    child: const Center(
                      child: Text('Подать заявку'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row dropdownMediaInput(
    double width,
    BuildContext context,
    String label,
    SvgPicture icon,
    List<String> options,
    String? value,
  ) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: DropdownButton<String>(
                  itemHeight: 50,
                  hint: Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey.withAlpha(200)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: _selectedMedia,
                  selectedItemBuilder: (context) {
                    return options.map<Widget>((type) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          type,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList();
                  },
                  items: options.map<DropdownMenuItem<String>>((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.fade,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? type) {
                    setState(() {
                      if (_selectedMedia != type) {
                        //_selectedType = null;
                        _selectedMedia = type;
                      }
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.expand_more),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row dropdownFormatInput(
    double width,
    BuildContext context,
    String label,
    SvgPicture icon,
    List<String> options,
    String? value,
  ) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: DropdownButton<String>(
                  itemHeight: 50,
                  hint: Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey.withAlpha(200)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: _selectedFormat,
                  selectedItemBuilder: (context) {
                    return options.map<Widget>((type) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          type,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList();
                  },
                  items: options.map<DropdownMenuItem<String>>((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.fade,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? type) {
                    setState(() {
                      if (_selectedFormat != type) {
                        //_selectedType = null;
                        _selectedFormat = type;
                      }
                    });
                  },
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.expand_more),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row goalInput(double width, BuildContext context, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: TextField(
                onChanged: (value) => _selectedGoal = value,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Цель посещения',
                  contentPadding: EdgeInsets.fromLTRB(
                    16,
                    5,
                    5,
                    16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row numberInput(double width, BuildContext context, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: TextField(
                onChanged: (value) => _selectedPhone = value,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Контактный номер',
                  contentPadding: EdgeInsets.fromLTRB(
                    16,
                    5,
                    5,
                    16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row emailInput(double width, BuildContext context, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: TextField(
                onChanged: (value) => _selectedEmail = value,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Адрес электронной почты',
                  contentPadding: EdgeInsets.fromLTRB(
                    16,
                    5,
                    5,
                    16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row stringRow(double width, BuildContext context, String fieldName,
      String content, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: ListTile(
              dense: true,
              title: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
              ),
              subtitle: Text(
                fieldName,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              trailing: Assets.icons.applicationFormGoal.svg(),
            ),
          ),
        )
      ],
    );
  }

  Row birthRow(double width, BuildContext context, DateTime birthday) {
    return Row(
      children: [
        SizedBox(
            width: width * 0.1,
            child: Assets.icons.applicationFormBirth.svg(width: 30)),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: ListTile(
              dense: true,
              title: Text(
                DateFormat('dd MMMM yyyy').format(birthday),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
              ),
              subtitle: Text(
                'Дата рождения',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              trailing: Assets.icons.applicationFormGoal.svg(),
            ),
          ),
        )
      ],
    );
  }

  Row datePicker(double width, BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: width * 0.1,
            child: Assets.icons.applicationFormDate.svg(width: 30)),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.75,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 16, right: 4),
                dense: true,
                title: Text(
                  _selectedDate != null
                      ? DateFormat('dd MMMM yyyy').format(_selectedDate!)
                      : 'Дата прибытия',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: _selectedDate != null ? 16 : 14,
                      color: _selectedDate != null
                          ? ColorName.primary
                          : Colors.grey),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: ColorName.cardBackground,
                              onPrimary: Colors.black, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    ColorName.primary, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                      barrierColor: Colors.transparent,
                      locale: const Locale('ru', 'RU'),
                      context: context,
                      currentDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                          DateTime.now().year, DateTime.now().month + 3),
                    );
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                  icon: const Icon(Icons.expand_more),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  bool isValid() =>
      _selectedDate != null &&
      _selectedEmail != null &&
      _selectedFormat != null &&
      _selectedGoal != null &&
      _selectedMedia != null &&
      _selectedPhone != null;
}

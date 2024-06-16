import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/models/application.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key, required this.applications});
  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Разрешения'),
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Assets.icons.backgroundMountains.svg(
              width: width,
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemCount: applications.length, //applications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(stops: [
                        0,
                        1
                      ], colors: [
                        Colors.white,
                        ColorName.cardBackground
                      ])),
                      child: Stack(
                        children: [
                          Positioned(
                            left: -20,
                            top: -20,
                            child: Assets.icons.applicationDetailTopLeft.svg(),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child:
                                Assets.icons.applicationDetailBottomRight.svg(),
                          ),
                          Positioned(
                            top: 10,
                            right: 15,
                            child: Text(
                              'Запись на ${DateFormat('dd MMMM yyyy').format(applications[index].date)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 40,
                            child: Text(
                              '${applications[index].oopt.name} природный парк',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          const Positioned(
                              bottom: 5,
                              right: 10,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )),
                          Positioned(
                            bottom: 10,
                            left: 16,
                            child: Row(
                              children: applications[index].status == '0'
                                  ? [
                                      Assets.icons.statusWaiting.svg(),
                                      const SizedBox(width: 6),
                                      Text(
                                        'На рассмотрении',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: const Color(0xFFF2B600)),
                                      ),
                                    ]
                                  : applications[index].status == '1'
                                      ? [
                                          Assets.icons.statusApproved.svg(),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Подтверждена',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: const Color(
                                                        0xFF0BA992)),
                                          ),
                                        ]
                                      : applications[index].status == '2'
                                          ? [
                                              Assets.icons.statusDeclined.svg(),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Отклонена',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ]
                                          : applications[index].status == '3'
                                              ? [
                                                  Assets.icons.statusDeclined
                                                      .svg(),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'Отменена',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.red),
                                                  ),
                                                ]
                                              : [
                                                  Assets.icons.statusWaiting
                                                      .svg(),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'На рассмотрении',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: const Color(
                                                                0xFFF2B600)),
                                                  ),
                                                ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

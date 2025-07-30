import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/get_countries/get_countries_cubit.dart';
import 'package:vibe_zo/Features/splash/presentation/manger/validate_token/validate_token_cubit.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../../../core/utils/commons.dart';
import '../../../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../splash/domain/entity/login_entity.dart';
import '../../manager/get_langs/get_langs_cubit.dart';
import '../../manager/setup_profile/setup_profile_cubit.dart';
import '../../manager/setup_profile_ui/setup_profile_cubit.dart';
import '../widgets/custom_country_chip.dart';

class SetupProfileScreenStepTwo extends StatefulWidget {
  const SetupProfileScreenStepTwo({super.key});

  @override
  State<SetupProfileScreenStepTwo> createState() =>
      _SetupProfileScreenStepTwoState();
}

class _SetupProfileScreenStepTwoState extends State<SetupProfileScreenStepTwo> {
  List<String> selectedCountries = [];
  List<String> selectedLangs = [];
  final int selectionLimit = 3;

  void toggleCountrySelection(String country) {
    setState(() {
      if (selectedCountries.contains(country)) {
        selectedCountries.remove(country);
      } else {
        if (selectedCountries.length >= selectionLimit) {
          showLimitDialog("country");
        } else {
          selectedCountries.add(country);
        }
      }
    });
  }

  void toggleLangSelection(String langCode) {
    setState(() {
      if (selectedLangs.contains(langCode)) {
        selectedLangs.remove(langCode);
      } else {
        if (selectedLangs.length >= selectionLimit) {
          showLimitDialog("language");
        } else {
          selectedLangs.add(langCode);
        }
      }
    });
  }

  void showLimitDialog(String type) {
    showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(title: "$type limit reached"),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLangsCubit>(
      context,
    ).getLangs(endPoint: Api.doServerGetLanguagesApiCall);
    BlocProvider.of<GetCountriesCubit>(
      context,
    ).getCountries(endPoint: Api.doServerGetCountriesApiCall);
  }

  @override
  Widget build(BuildContext context) {
    String tokenValue = Hive.box(kUserTokenBox).get(kUserTokenBox) ?? '';

    return MultiBlocListener(
      listeners: [
        BlocListener<GetCountriesCubit, GetCountriesState>(
          listener: (context, state) {},
        ),
        BlocListener<GetLangsCubit, GetLangsState>(
          listener: (context, state) {},
        ),
        BlocListener<SetupProfileCubit, SetupProfileState>(
          listener: (context, state) async {
            if (state is SetupProfileSuccessful) {
              //خزن الداتا يعني اعمل فاليديت توكن

              await Hive.box(kLoginTokenBox).clear();
              await Hive.box(
                kLoginTokenBox,
              ).put(kLoginTokenBox, state.user.data!.token!.token);
              await BlocProvider.of<ValidateTokenCubit>(context).validateToken(
                token: Hive.box(kLoginTokenBox).get(kLoginTokenBox),
              );
              // Navigator.pop(context);
              //Go Home Screen
            }
            if (state is SetupProfileFailed) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(title: state.message);
                },
              );
            }
            if (state is SetupProfileLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CustomLoadiNgWidget());
                },
              );
            }
          },
        ),
        BlocListener<ValidateTokenCubit, ValidateTokenState>(
          listener: (context, state) async {
            if (state is ValidateTokenSuccessful) {
              final box = await Hive.openBox<LoginEntity>(kUserDataBox);
              await box.clear();

              await box.put(kUserDataBox, state.user);

              Navigator.pushNamedAndRemoveUntil(
                context,
                kBottomNavRoute,
                (route) => false,
              );
            }
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAuthAppBar(
              hasArrowBackButton: true,
              onBackButtonPressed: () {
                BlocProvider.of<SetupProfileUiCubit>(context).changeStep(1);
              },
              title: context.locale.translate("lets_setup_profile")!,
            ),
            const SizedBox(height: 36),

            /// Spoken Languages
            Text(context.locale.translate("spoken_language")!),
            const SizedBox(height: 8),
            BlocBuilder<GetLangsCubit, GetLangsState>(
              builder: (context, langsState) {
                return (langsState is GetLangsSuccessful)
                    ? Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ...langsState.user.data!
                              .where((e) => selectedLangs.contains(e.code))
                              .followedBy(
                                langsState.user.data!
                                    .where(
                                      (e) => !selectedLangs.contains(e.code),
                                    )
                                    .take(5 - selectedLangs.length),
                              )
                              .toSet()
                              .toList()
                              .map(
                                (e) => CustomCountryChip(
                                  name: e.name ?? "",
                                  isSelected: selectedLangs.contains(e.code!),
                                  onSelect: () => toggleLangSelection(e.code!),
                                ),
                              ),
                          CustomCountryChip(
                            name: context.locale.translate("more")!,
                            isSelected: false,
                            onSelect: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) => _buildBottomSheet(
                                  context: context,
                                  title:
                                      context.locale.translate(
                                        "search_language",
                                      ) ??
                                      "Search",
                                  allItems: langsState.user.data!,
                                  isLanguage: true,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
              },
            ),
            const SizedBox(height: 24),

            /// Countries
            Text(context.locale.translate("where_are_you_from")!),
            const SizedBox(height: 8),
            BlocBuilder<GetCountriesCubit, GetCountriesState>(
              builder: (context, countriesState) {
                return (countriesState is GetCountriesSuccessful)
                    ? Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ...countriesState.user.data!
                              .where((e) => selectedCountries.contains(e.code))
                              .followedBy(
                                countriesState.user.data!
                                    .where(
                                      (e) =>
                                          !selectedCountries.contains(e.code),
                                    )
                                    .take(5 - selectedCountries.length),
                              )
                              .toSet()
                              .toList()
                              .map(
                                (e) => CustomCountryChip(
                                  flag: CountryFlag.fromCountryCode(
                                    e.code!,
                                    shape: Circle(),
                                    height: 18,
                                    width: 18,
                                  ),
                                  name: context.locale.isEnLocale
                                      ? e.nameEn ?? ''
                                      : e.nameAr ?? '',
                                  isSelected: selectedCountries.contains(
                                    e.code,
                                  ),
                                  onSelect: () =>
                                      toggleCountrySelection(e.code!),
                                ),
                              ),
                          CustomCountryChip(
                            name: context.locale.translate("more")!,
                            isSelected: false,
                            onSelect: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) => _buildBottomSheet(
                                  context: context,
                                  title:
                                      context.locale.translate(
                                        "search_country",
                                      ) ??
                                      "Search",
                                  allItems: countriesState.user.data!,
                                  isLanguage: false,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
              },
            ),

            const Spacer(),
            CustomButton(
              screenWidth: context.screenWidth,
              buttonTapHandler: () async {
                (selectedCountries.isNotEmpty && selectedLangs.isNotEmpty)
                    ? await BlocProvider.of<SetupProfileCubit>(
                        context,
                      ).setupProfile(
                        userName: BlocProvider.of<SetupProfileUiCubit>(
                          context,
                        ).idNumber!,
                        name: BlocProvider.of<SetupProfileUiCubit>(
                          context,
                        ).name!,
                        birthDate: BlocProvider.of<SetupProfileUiCubit>(
                          context,
                        ).birthDate!.split('/').reversed.join('-'),
                        gender: BlocProvider.of<SetupProfileUiCubit>(
                          context,
                        ).gender!,
                        spokenLanguages: selectedLangs,
                        countries: selectedCountries,
                        photo: BlocProvider.of<SetupProfileUiCubit>(
                          context,
                        ).profileImage!,
                        token: tokenValue,
                      )
                    : Commons.showToast(
                        context,
                        message: "Select at least one language and country",
                      );
              },
              buttonText: context.locale.translate("continue")!,
              btnTxtFontSize: 14,
              withIcon: true,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet({
    required BuildContext context,
    required String title,
    required List<dynamic> allItems,
    required bool isLanguage,
  }) {
    final TextEditingController searchController = TextEditingController();
    List<dynamic> filteredItems = List.from(allItems);

    return StatefulBuilder(
      builder: (context, setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: title,
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          filteredItems = allItems
                              .where(
                                (item) =>
                                    (isLanguage
                                            ? item.name
                                            : (item.nameAr ?? '') +
                                                  (item.nameEn ?? ''))
                                        .toLowerCase()
                                        .contains(val.toLowerCase()),
                              )
                              .toList();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 180,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3.5,
                          ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final e = filteredItems[index];
                        return CustomCountryChip(
                          flag: isLanguage
                              ? null
                              : CountryFlag.fromCountryCode(
                                  e.code!,
                                  shape: Circle(),
                                  height: 18,
                                  width: 18,
                                ),
                          name: isLanguage
                              ? e.name ?? ''
                              : (context.locale.isEnLocale
                                    ? e.nameEn ?? ''
                                    : e.nameAr ?? ''),
                          isSelected: isLanguage
                              ? selectedLangs.contains(e.code)
                              : selectedCountries.contains(e.code),
                          onSelect: () {
                            if (e.code != null) {
                              isLanguage
                                  ? toggleLangSelection(e.code!)
                                  : toggleCountrySelection(e.code!);
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

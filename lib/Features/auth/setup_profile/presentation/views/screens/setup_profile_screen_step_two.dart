import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/get_countries/get_countries_cubit.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';

import '../../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import '../../manager/get_langs/get_langs_cubit.dart';
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

  void toggleCountrySelection(String country) {
    setState(() {
      if (selectedCountries.contains(country)) {
        selectedCountries.remove(country);
      } else {
        selectedCountries.add(country);
      }
    });
  }

  void toggleLangSelection(String lang) {
    setState(() {
      if (selectedLangs.contains(lang)) {
        selectedLangs.remove(lang);
      } else {
        selectedLangs.add(lang);
      }
    });
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
    return MultiBlocListener(
      listeners: [
        BlocListener<GetCountriesCubit, GetCountriesState>(
          listener: (context, state) {},
        ),
        BlocListener<GetLangsCubit, GetLangsState>(
          listener: (context, state) {},
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            CustomAuthAppBar(
              title: context.locale.translate("lets_setup_profile")!,
            ),
            const SizedBox(height: 36),

            /// Spoken Languages
            Text(context.locale.translate("spoken_language")!),
            const SizedBox(height: 8),
            BlocBuilder<GetLangsCubit, GetLangsState>(
              builder: (context, langsState) {
                return (langsState is GetLangsSuccessful)
                    ? BlocBuilder<AnimationCubit, AnimationState>(
                        builder: (context, state) {
                          if (!BlocProvider.of<AnimationCubit>(
                            context,
                          ).isShowAllLangs) {
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ...langsState.user.data!
                                    .take(5)
                                    .map(
                                      (e) => CustomCountryChip(
                                        name: e.name ?? "",
                                        isSelected: selectedLangs.contains(
                                          e.name,
                                        ),
                                        onSelect: () =>
                                            toggleLangSelection(e.name!),
                                      ),
                                    ),
                                CustomCountryChip(
                                  name: context.locale.translate("more")!,
                                  isSelected: false,
                                  onSelect: () {
                                    BlocProvider.of<AnimationCubit>(
                                      context,
                                    ).showAllLanguages();
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ...langsState.user.data!.map(
                                  (e) => CustomCountryChip(
                                    name: e.name ?? "",
                                    isSelected: selectedLangs.contains(e.name),
                                    onSelect: () =>
                                        toggleLangSelection(e.name!),
                                  ),
                                ),
                                CustomCountryChip(
                                  name: context.locale.translate("more")!,
                                  isSelected: false,
                                  onSelect: () {
                                    BlocProvider.of<AnimationCubit>(
                                      context,
                                    ).showAllLanguages();
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
              },
            ),

            const SizedBox(height: 24),

            Text(context.locale.translate("where_are_you_from")!),
            const SizedBox(height: 8),
            BlocBuilder<GetCountriesCubit, GetCountriesState>(
              builder: (context, countriesState) {
                return (countriesState is GetCountriesSuccessful)
                    ? BlocBuilder<AnimationCubit, AnimationState>(
                        builder: (context, state) {
                          if (!BlocProvider.of<AnimationCubit>(
                            context,
                          ).isShowAllCountries) {
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ...countriesState.user.data!
                                    .take(5)
                                    .map(
                                      (e) => CustomCountryChip(
                                        flag: CountryFlag.fromCountryCode(
                                          e.code!,
                                          shape: Circle(),
                                          height: 18,
                                          width: 18,
                                        ),
                                        name: context.locale.isEnLocale
                                            ? e.nameEn ?? ""
                                            : e.nameAr ?? "",
                                        isSelected: selectedLangs.contains(
                                          e.code,
                                        ),
                                        onSelect: () =>
                                            toggleLangSelection(e.code!),
                                      ),
                                    ),
                                CustomCountryChip(
                                  name: context.locale.translate("more")!,
                                  isSelected: false,
                                  onSelect: () {
                                    BlocProvider.of<AnimationCubit>(
                                      context,
                                    ).showAllCountries();
                                  },
                                ),
                              ],
                            );
                          } else {
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ...countriesState.user.data!.map(
                                  (e) => CustomCountryChip(
                                    flag: CountryFlag.fromCountryCode(
                                      e.code!,
                                      shape: Circle(),
                                      height: 18,
                                      width: 18,
                                    ),
                                    name: context.locale.isEnLocale
                                        ? e.nameEn ?? ""
                                        : e.nameAr ?? "",
                                    isSelected: selectedLangs.contains(e.code),
                                    onSelect: () =>
                                        toggleLangSelection(e.code!),
                                  ),
                                ),
                                CustomCountryChip(
                                  name: context.locale.translate("more")!,
                                  isSelected: false,
                                  onSelect: () {
                                    BlocProvider.of<AnimationCubit>(
                                      context,
                                    ).showAllCountries();
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
              },
            ),

            const SizedBox(height: 60),

            CustomButton(
              screenWidth: context.screenWidth,
              buttonTapHandler: () {
                // Action on continue
              },
              buttonText: context.locale.translate("continue")!,
              btnTxtFontSize: 14,
              withIcon: true,
              // icon: AssetsData.continueIcon,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

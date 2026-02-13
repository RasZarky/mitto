import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mitto/core/router/app_router.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';
import 'package:mitto/core/widgets/app_app_bar.dart';
import 'package:mitto/core/widgets/app_secondary_text_field.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/providers/country_provider.dart';

class ChooseCountryPage extends StatefulWidget {
  const ChooseCountryPage({super.key});

  @override
  State<ChooseCountryPage> createState() => _ChooseCountryPageState();
}

class _ChooseCountryPageState extends State<ChooseCountryPage> {
  List<Country> allCountries = [];
  List<Country> filteredCountries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() {
    // Get all countries from the provider
    allCountries = CountryProvider.getCountriesData(countries: null);
    filteredCountries = allCountries;
  }

  void _filterCountries(String query) {
    setState(() {
      filteredCountries = allCountries
          .where((country) =>
              country.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: const AppAppBar(
        title: 'Choose Country',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Choose your \ncountry', style: AppTextStyle.h1Semibold),
            const SizedBox(height: 8),
            Text(
              'Select where you’re sending money from.',
              style: AppTextStyle.lgRegular.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 48),
            Center(
              child: AppSecondaryTextField(
                hintText: 'Search country',
                controller: _searchController,
                onChanged: _filterCountries,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.gray800,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onTap: () {
                        context.push(AppRouter.createPassword);
                      },
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          country.flagUri,
                          package: 'intl_phone_number_input',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.flag, color: Colors.white),
                        ),
                      ),
                      title: Text(
                        country.name ?? '',
                        style: AppTextStyle.lgRegular,
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.gray400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

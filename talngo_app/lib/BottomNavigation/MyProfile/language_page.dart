import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talngo_app/Locale/language_cubit.dart';
import 'package:talngo_app/Locale/locale.dart';
import 'package:talngo_app/Routes/routes.dart';
import 'package:talngo_app/Theme/colors.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeLanguagePageState createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _languages = [
      'English',
      'عربى',
      'français',
      'bahasa Indonesia',
      'português',
      'Español',
      'italiano',
      'Türk',
      'Kiswahili'
    ];
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        _selectedLanguage = getCurrentLanguage(locale);
        return Container(
          decoration:  BoxDecoration(
          gradient: lGradient),
          child: Scaffold(
            backgroundColor: transparentColor,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.changeLanguage!),
            ),
            body:
            SafeArea(
              child: Stack(
        
                children: [
                  FadedSlideAnimation(
                   child: ListView.builder(
                      itemCount: _languages.length,
                      itemBuilder: (context, index) => RadioListTile(
                        onChanged: (dynamic value) async {
                          setState(() {
                            _selectedLanguage = value;
        
                          });
                          if (_selectedLanguage == 0) {
                            _languageCubit.selectEngLanguage();
                          } else if (_selectedLanguage == 1) {
                            _languageCubit.selectArabicLanguage();
                          } else if (_selectedLanguage == 2) {
                            _languageCubit.selectFrenchLanguage();
                          } else if (_selectedLanguage == 3) {
                            _languageCubit.selectIndonesianLanguage();
                          } else if (_selectedLanguage == 4) {
                            _languageCubit.selectPortugueseLanguage();
                          } else if (_selectedLanguage == 5) {
                            _languageCubit.selectSpanishLanguage();
                          } else if (_selectedLanguage == 6) {
                            _languageCubit.selectItalianLanguage();
                          } else if (_selectedLanguage == 7) {
                            _languageCubit.selectTurkishLanguage();
                          } else if (_selectedLanguage == 8) {
                            _languageCubit.selectSwahiliLanguage();
                          }
                        },
                        groupValue: _selectedLanguage,
                        value: index,
                        title: Text(_languages[index]),
                      ),
                    ),
                    beginOffset: Offset(0, 0.3),
                    endOffset: Offset(0, 0),
                    slideCurve: Curves.linearToEaseOut,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child:
                    Padding(
                      padding: const EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 50),
                      child: GestureDetector(
                        onTap: (){
        
                          Navigator.pushNamed(context, PageRoutes.bottomNavigation);
        
        
        
        
                        },
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(child: Text("Next",style: GoogleFonts.poppins(fontSize: 14,textStyle: TextStyle(color:Colors.white)))),
                        ),
                      ),
                    ),
                  )
        
                ],
        
              ),
            ),
          ),
        );
      },
    );
  }

  int getCurrentLanguage(Locale locale) {
    if (locale == Locale('en'))
      return 0;
    else if (locale == Locale('ar'))
      return 1;
    else if (locale == Locale('fr'))
      return 2;
    else if (locale == Locale('id'))
      return 3;
    else if (locale == Locale('pt'))
      return 4;
    else if (locale == Locale('es'))
      return 5;
    else if (locale == Locale('it'))
      return 6;
    else if (locale == Locale('tr'))
      return 7;
    else if (locale == Locale('sw'))
      return 8;
    else
      return -1;
  }
}

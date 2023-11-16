import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';

class SystemLocalizationSelector extends ConsumerWidget {
  const SystemLocalizationSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleServiceProvider);

    const double flagSize = 32;

    return TextButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Please select a country',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: Localization.delegate.supportedLocales.map(
                          (locale) {
                            final selected = currentLocale.languageCode ==
                                locale.languageCode;

                            return ListTile(
                              selected: selected,
                              selectedColor:
                                  context.colorScheme.onSurfaceVariant,
                              selectedTileColor:
                                  context.colorScheme.surfaceVariant,
                              leading: SizedBox(
                                width: flagSize,
                                height: flagSize / CountryFlag.kFlagAspectRatio,
                                child: CountryFlag(
                                  width: flagSize,
                                  countryCode:
                                      locale.countryCode ?? locale.languageCode,
                                ),
                              ),
                              title: Text(_isoLangs[locale.languageCode] ??
                                  locale.languageCode),
                              titleTextStyle: TextStyle(
                                fontWeight: selected ? FontWeight.w700 : null,
                              ),
                              onTap: () {
                                ref
                                    .read(currentLocaleServiceProvider.notifier)
                                    .update(locale);

                                Navigator.of(context).pop();
                              },
                              minVerticalPadding: 15,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              );
            });
      },
      child: Row(
        children: [
          Text(_isoLangs[currentLocale.languageCode] ??
              currentLocale.languageCode),
          const Gap(10),
          CountryFlag(
            width: 15,
            countryCode:
                currentLocale.countryCode ?? currentLocale.languageCode,
          ),
        ],
      ),
    );
  }
}

final _isoLangs = {
  "ab": "аҧсуа",
  "aa": "Afaraf",
  "af": "Afrikaans",
  "ak": "Akan",
  "sq": "Shqip",
  "am": "አማርኛ",
  "ar": "العربية",
  "an": "Aragonés",
  "hy": "Հայերեն",
  "as": "অসমীয়া",
  "av": "авар мацӀ, магӀарул мацӀ",
  "ae": "avesta",
  "ay": "aymar aru",
  "az": "azərbaycan dili",
  "bm": "bamanankan",
  "ba": "башҡорт теле",
  "eu": "euskara, euskera",
  "be": "Беларуская",
  "bn": "বাংলা",
  "bh": "भोजपुरी",
  "bi": "Bislama",
  "bs": "bosanski jezik",
  "br": "brezhoneg",
  "bg": "български език",
  "my": "ဗမာစာ",
  "ca": "Català",
  "ch": "Chamoru",
  "ce": "нохчийн мотт",
  "ny": "chiCheŵa, chinyanja",
  "zh": "中文 (Zhōngwén), 汉语, 漢語",
  "cv": "чӑваш чӗлхи",
  "kw": "Kernewek",
  "co": "corsu, lingua corsa",
  "cr": "ᓀᐦᐃᔭᐍᐏᐣ",
  "hr": "hrvatski",
  "cs": "česky, čeština",
  "da": "dansk",
  "dv": "ދިވެހި",
  "nl": "Nederlands, Vlaams",
  "en": "English",
  "eo": "Esperanto",
  "et": "eesti, eesti keel",
  "ee": "Eʋegbe",
  "fo": "føroyskt",
  "fj": "vosa Vakaviti",
  "fi": "suomi, suomen kieli",
  "fr": "français, langue française",
  "ff": "Fulfulde, Pulaar, Pular",
  "gl": "Galego",
  "ka": "ქართული",
  "de": "Deutsch",
  "el": "Ελληνικά",
  "gn": "Avañeẽ",
  "gu": "ગુજરાતી",
  "ht": "Kreyòl ayisyen",
  "ha": "Hausa, هَوُسَ",
  "he": "עברית",
  "hz": "Otjiherero",
  "hi": "हिन्दी, हिंदी",
  "ho": "Hiri Motu",
  "hu": "Magyar",
  "ia": "Interlingua",
  "id": "Bahasa Indonesia",
  "ie": "Originally called Occidental; then Interlingue after WWII",
  "ga": "Gaeilge",
  "ig": "Asụsụ Igbo",
  "ik": "Iñupiaq, Iñupiatun",
  "io": "Ido",
  "is": "Íslenska",
  "it": "Italiano",
  "iu": "ᐃᓄᒃᑎᑐᑦ",
  "ja": "日本語 (にほんご／にっぽんご)",
  "jv": "basa Jawa",
  "kl": "kalaallisut, kalaallit oqaasii",
  "kn": "ಕನ್ನಡ",
  "kr": "Kanuri",
  "ks": "कश्मीरी, كشميري‎",
  "kk": "Қазақ тілі",
  "km": "ភាសាខ្មែរ",
  "ki": "Gĩkũyũ",
  "rw": "Ikinyarwanda",
  "ky": "кыргыз тили",
  "kv": "коми кыв",
  "kg": "KiKongo",
  "ko": "한국어 (韓國語), 조선말 (朝鮮語)",
  "ku": "Kurdî, كوردی‎",
  "kj": "Kuanyama",
  "la": "latine, lingua latina",
  "lb": "Lëtzebuergesch",
  "lg": "Luganda",
  "li": "Limburgs",
  "ln": "Lingála",
  "lo": "ພາສາລາວ",
  "lt": "lietuvių kalba",
  "lv": "latviešu valoda",
  "gv": "Gaelg, Gailck",
  "mk": "македонски јазик",
  "mg": "Malagasy fiteny",
  "ms": "bahasa Melayu, بهاس ملايو‎",
  "ml": "മലയാളം",
  "mt": "Malti",
  "mi": "te reo Māori",
  "mr": "मराठी",
  "mh": "Kajin M̧ajeļ",
  "mn": "монгол",
  "na": "Ekakairũ Naoero",
  "nv": "Diné bizaad, Dinékʼehǰí",
  "nb": "Norsk bokmål",
  "nd": "isiNdebele",
  "ne": "नेपाली",
  "ng": "Owambo",
  "nn": "Norsk nynorsk",
  "no": "Norsk",
  "ii": "ꆈꌠ꒿ Nuosuhxop",
  "nr": "isiNdebele",
  "oc": "Occitan",
  "oj": "ᐊᓂᔑᓈᐯᒧᐎᓐ",
  "cu": "ѩзыкъ словѣньскъ",
  "om": "Afaan Oromoo",
  "or": "ଓଡ଼ିଆ",
  "os": "ирон æвзаг",
  "pa": "ਪੰਜਾਬੀ, پنجابی‎",
  "pi": "पाऴि",
  "fa": "فارسی",
  "pl": "polski",
  "ps": "پښتو",
  "pt": "Português",
  "qu": "Runa Simi, Kichwa",
  "rm": "rumantsch grischun",
  "rn": "kiRundi",
  "ro": "română",
  "ru": "русский язык",
  "sa": "संस्कृतम्",
  "sc": "sardu",
  "sd": "सिन्धी, سنڌي، سندھی‎",
  "se": "Davvisámegiella",
  "sm": "gagana faa Samoa",
  "sg": "yângâ tî sängö",
  "sr": "српски језик",
  "gd": "Gàidhlig",
  "sn": "chiShona",
  "si": "සිංහල",
  "sk": "slovenčina",
  "sl": "slovenščina",
  "so": "Soomaaliga, af Soomaali",
  "st": "Sesotho",
  "es": "español, castellano",
  "su": "Basa Sunda",
  "sw": "Kiswahili",
  "ss": "SiSwati",
  "sv": "svenska",
  "ta": "தமிழ்",
  "te": "తెలుగు",
  "tg": "тоҷикӣ, toğikī, تاجیکی‎",
  "th": "ไทย",
  "ti": "ትግርኛ",
  "bo": "བོད་ཡིག",
  "tk": "Türkmen, Түркмен",
  "tl": "Wikang Tagalog, ᜏᜒᜃᜅ᜔ ᜆᜄᜎᜓᜄ᜔",
  "tn": "Setswana",
  "to": "faka Tonga",
  "tr": "Türkçe",
  "ts": "Xitsonga",
  "tt": "татарча, tatarça, تاتارچا‎",
  "tw": "Twi",
  "ty": "Reo Tahiti",
  "ug": "Uyƣurqə, ئۇيغۇرچە‎",
  "uk": "українська",
  "ur": "اردو",
  "uz": "zbek, Ўзбек, أۇزبېك‎",
  "ve": "Tshivenḓa",
  "vi": "Tiếng Việt",
  "vo": "Volapük",
  "wa": "Walon",
  "cy": "Cymraeg",
  "wo": "Wollof",
  "fy": "Frysk",
  "xh": "isiXhosa",
  "yi": "ייִדיש",
  "yo": "Yorùbá",
  "za": "Saɯ cueŋƅ, Saw cuengh",
};

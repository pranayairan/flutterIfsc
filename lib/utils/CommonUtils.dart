class CommonUtils {
  static List<CurrencyConverterData> currencyName = [
    CurrencyConverterData("Indian Rupee: INR", "INR"),
    CurrencyConverterData("U.S Dollar: USD", "USD"),
    CurrencyConverterData("Australian Dollar: AUD ", "AUD"),
    CurrencyConverterData("Bulgarian Lev: BGN", "BGN"),
    CurrencyConverterData("Brazilian Real: BRL", "BRL"),
    CurrencyConverterData("Canadian Dollar: CAD", "CAD"),
    CurrencyConverterData("Swiss Franc: CHF", "CHF"),
    CurrencyConverterData("Chinese Yuan: CNY", "CNY"),
    CurrencyConverterData("Czech Koruna: CZK", "CZK"),
    CurrencyConverterData("Danish Krone: DKK", "DKK"),
    CurrencyConverterData("Euro: EUR", "EUR"),
    CurrencyConverterData("British Pound: GBP", "GBP"),
    CurrencyConverterData("Hong Kong Dollar: HKD", "HKD"),
    CurrencyConverterData("Croatian Kuna: HRK", "HRK"),
    CurrencyConverterData("Hungarian Forint: HUF", "HUF"),
    CurrencyConverterData("Indonesian Rupiah: IDR", "IDR"),
    CurrencyConverterData("Israeli New Shekel: ILS", "ILS"),
    CurrencyConverterData("Japanese Yen: JPY", "JPY"),
    CurrencyConverterData("South Korean Won: KRW", "KRW"),
    CurrencyConverterData("Mexican Peso: MXN", "MXN"),
    CurrencyConverterData("Malaysian Ringgit: MYR", "MYR"),
    CurrencyConverterData("Norwegian Krone: NOK", "NOK"),
    CurrencyConverterData("New Zealand Dollar: NZD", "NZD"),
    CurrencyConverterData("Philippine Peso: PHP", "PHP"),
    CurrencyConverterData("Polish Zloty: PLN", "PLN"),
    CurrencyConverterData("Romanian Leu: RON", "RON"),
    CurrencyConverterData("Russian Ruble: RUB", "RUB"),
    CurrencyConverterData("Swedish Krona: SEK", "SEK"),
    CurrencyConverterData("Singapore Dollar: SGD", "SGD"),
    CurrencyConverterData("Thai Baht: THB", "THB"),
    CurrencyConverterData("Turkish Lira: TRY", "TRY"),
    CurrencyConverterData("South African Rand: ZAR", "ZAR")
  ];
}

class CurrencyConverterData {
  final String currencyName;
  final String currencyValue;

  CurrencyConverterData(this.currencyName, this.currencyValue);
}

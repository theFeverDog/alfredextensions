#theFeverDog's Alfred Extensions

##Alfred Currency Converter

* *Requires internet connection*. Uses Google Currency Converter to get latest exchange rates.

* *Requires Growl to display results.*

###Basic usage
Once the extension is installed, open Alfred and type:

	convert X <oldcurrency> to <newcurrency>

If you're connected to the internet, you'll get a Growl popup showing you the converted amount.

You can use any three-letter ISO currency codes (e.g. USD, EUR, GBP…) supported by Google Currency Converter.

If you want to save some time (and hey, you’re using Alfred, so this should be right up your alley), you can shorten things up a bit by leaving away the “to” keyword, our using your keyboard’s currency symbols ($, €, £, ¥ are currently supported):

	convert 1.234 USD GBP
	convert 1.2 $ to £
	convert 1.2 $ €

###Default currency
You can also set a default target currency in the script (default = EUR), making things even shorter:

	convert 2.345 SEK
	convert 2.345 $
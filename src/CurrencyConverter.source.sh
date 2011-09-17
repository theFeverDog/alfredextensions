# USAGE:
# ------
# convert 10 <3 Letter Code> [to <3 Letter Code>]

# EXAMPLES (all 4 produce the same output):
# -----------------------------------------
# convert 10 USD to EUR
# convert 10 USD EUR
# convert 10 USD (with DEFAULT='EUR')
# convert 10 $ to €

# SETTINGS (you can edit here):
# ----------------------------
# Default Target Currency - if no 3rd argument is provided,
# the amount is converted to the default target currency.
DEFAULT='EUR'



# SCRIPT (don't edit below unless you know what you're doing):
# ------------------------------------------------------------
# Before using this in alfred replace $1 in the following line with {query}.
# Replace currency symbols with their 3 letter codes.
QUERY=`echo $1 " " | sed "s/ $ / USD /g;s/ € / EUR /g;s/ £ / GBP /g;s/ ¥ / JPY /g"`

# Split Alfred query into parts:
AMOUNT=`echo $QUERY | awk '{ print $1; }' | sed 's/,/./g'`
INPUT=`echo $QUERY | awk '{ print toupper($2); }' `
TO=`echo $QUERY| awk '{ print toupper($3); }'`
TARGET=`echo $QUERY | awk '{ print toupper($4); }'`

# Check if we have TO/target, otherwise use default target.
if [ "$TO" = "" ]; then
TARGET=$DEFAULT
fi

# Check if a TO is provided, otherwise use TO as Target.
if [ "$TARGET" = "" ]; then
	TARGET=$TO
fi

# Check length of Input and Target strings - we're looking for 3 letter codes.
if [ "${#INPUT}" -le 3 ] & [ "${#TARGET}" -le 3 ]; then
# Get exchange rate
  if [ "$TARGET" != "$INPUT" ]; then
    RESULT=`curl -s "http://www.google.com/finance/converter?a=$AMOUNT&from=$INPUT&to=$TARGET" | awk '/<span/{print}' | sed -e 's/<[^>][^>]*>//g' -e '/^ *$/d'`
    if [ "$RESULT" != "" ]; then
      echo $RESULT
    else
      echo 'You provided an unknown currency code.'
    fi
  else
    echo $AMOUNT $INPUT ' = ' $AMOUNT $TARGET
    echo 'Maybe you want to provide different currencies or change the default currency?'
  fi
else
  echo 'Please use 3-letter currency codes (e.g. USD) or use one of the following symbols: $, €, £, ¥.'
fi
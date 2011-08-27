# USAGE:
# ------
# convert 10 <3 Letter Code> [to <3 Letter Code>]

# EXAMPLES (all 3 produce the same output):
# -----------------------------------------
# convert 10 USD to EUR
# convert 10 USD EUR
# convert 10 USD (with DEFAULT='EUR')

# SETTINGS:
# ---------
# Default Target Currency - if no 3rd argument is provided,
# the amount is converted to the default target currency.
DEFAULT='EUR'

# SCRIPT:
# -------
# Split Alfred query into parts:
AMOUNT=`echo '{query}' | awk '{ print $1; }' | sed 's/,/./g'`
INPUT=`echo '{query}' | awk '{ print toupper($2); }'  `
TO=`echo '{query}' | awk '{ print toupper($3); }'`
TARGET=`echo '{query}' | awk '{ print toupper($4); }'`

# Check if we have TO/target, otherwise use default target.
if [ "$TO" = "" ]; then
TARGET=$DEFAULT
fi

# Check if a TO is provided, otherwise use TO as Target.
if [ "$TARGET" = "" ]; then
	TARGET=$TO
fi

# Get exchange rate
if [ $TARGET != $INPUT ]; then
curl -s "http://www.google.com/finance/converter?a=$AMOUNT&from=$INPUT&to=$TARGET" | awk '/<span/{print}' | sed -e 's/<[^>][^>]*>//g' -e '/^ *$/d'
else
echo $AMOUNT $INPUT ' = ' $AMOUNT $TARGET
echo 'Maybe you want to provide different currencies or change the default currency?'
fi
#!/bin/bash

city=Taipei
cachedir="$HOME/.cache/rbn"
cachefile="${0##*/}"
[ -n "$1" ] && cachefile="$cachefile-$1"

mkdir -p "$cachedir"

if [ ! -f "$cachedir/$cachefile" ]; then
    touch "$cachedir/$cachefile"
fi

# Save and change IFS
SAVEIFS=$IFS
IFS=$'\n'

if stat --version &>/dev/null; then
    cacheage=$(($(date +%s) - $(stat -c '%Y' "$cachedir/$cachefile")))
else
    cacheage=$(($(date +%s) - $(stat -f '%m' "$cachedir/$cachefile")))
fi

if [ "$cacheage" -gt 1740 ] || [ ! -s "$cachedir/$cachefile" ]; then
    data=($(curl -s https://en.wttr.in/"$city"$1\?0qnT 2>/dev/null))
    
    if [ ${#data[@]} -lt 3 ]; then
        echo "Error: Failed to fetch weather data" > "$cachedir/$cachefile"
        exit 1
    fi

    echo "${data[0]}" | cut -f1 -d, > "$cachedir/$cachefile"
    echo "${data[1]}" | sed -E 's/^.{15}//' >> "$cachedir/$cachefile"
    echo "${data[2]}" | sed -E 's/^.{15}//' >> "$cachedir/$cachefile"
fi

mapfile -t weather < "$cachedir/$cachefile"

IFS=$SAVEIFS

temperature=$(echo "${weather[2]}" | sed -E 's/([[:digit:]]+)\.\.([[:digit:]]+)/\1 to \2/g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//') # Remove leading/trailing spaces
escaped_weather=$(echo "${weather[1]}" | sed 's/"/\\"/g')

weather_condition=$(echo "${weather[1]}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Debug the cleaned string and its length
# echo "Cleaned Weather condition: $weather_condition"
# echo "Weather condition length: ${#weather_condition}"

# Force conversion to lowercase
weather_condition_lower=$(echo "$weather_condition" | tr '[:upper:]' '[:lower:]')

# Debug the lowercase version
# echo "Lowercase Weather condition: $weather_condition_lower"

case "$weather_condition_lower" in
"clear" | "sunny")
    condition=""
    ;;
"partly cloudy")
    condition="󰖕"
    ;;
"cloudy")
    condition=""
    ;;
"overcast")
    condition=""
    ;;
"fog" | "freezing fog")
    condition=""
    ;;
"patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "mist" | "rain")
    condition="󰼳"
    ;;
"moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
    condition=""
    ;;
"patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
    condition="󰼴"
    ;;
"blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
    condition="󰙿"
    ;;
"blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
    condition=""
    ;;
"thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
    condition=""
    ;;
*)
    condition=""
    ;;
esac

# Output the weather info with condition symbol and temperature
echo -e "{\"text\":\"$temperature $condition\", \"alt\":\"${weather[0]}\", \"tooltip\":\"${weather[0]}: $temperature ${escaped_weather}\"}"

cached_weather=" $temperature  \n$condition ${weather[1]}"

echo -e "$cached_weather" >  ~/.cache/.weather_cache

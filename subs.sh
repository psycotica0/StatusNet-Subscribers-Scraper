profile="$1"
nextFile="`mktemp`"

echo "$profile/subscribers" > "$nextFile"

while [ -n "`cat $nextFile`" ]; do
	url="`cat $nextFile`"
	curl -sL "$url" | scrape -a '' -b '' -d ' ' -s 'ul class="profiles"' -c 'href="([^"]*)" rel="next"' 'vcard">\s*<a href="([^"]*)"' 2> "$nextFile"
done;

rm -f "$nextFile"

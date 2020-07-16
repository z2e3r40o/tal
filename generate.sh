# copy over html and muse files from torrent download
# html files are distributed as is
# muse metadata is used to generate the index file
mkdir -p library
find "$1" -name '*.html' -exec cp -t ./library/ {} +
find "$1" -name '*.muse' -exec cp -t ./library/ {} +

# generate new index file and overwrite the one with broken links
rm -f index.html
cat > index.html <<- EOM
<!DOCTYPE html>
<html>
    <head>
        <title>The Anarchist Library</title>
        <style>
        .flag {
            text-align: right;
        }

        div {
            margin-bottom: 3px;
        }
        </style>
    </head>
    <body>
        <div class="flag"><img src="./Anarchist_flag.svg" alt="Anarchist flag" width="225" height="150"></div>
        <p>
            This site is an html only distribution of <a href="https://theanarchistlibrary.org/special/the-torrent-2019-winter">theanarchistlibrary.org</a>.
        </p>
EOM
for file in ./library/*.muse; do
    filename="$(basename $file .muse)"
    htmlfile="./$filename.html"
    if [ ! -f "./library/$htmlfile" ]
    then
        echo "filename not found ./library/$htmlfile"
    else
        echo "<div><a href='$htmlfile'>" >> index.html

        title="$(grep "^#title" $file | cut -d " " -f2-)"
        if [ ! -z "$title" ]
        then
            echo "<strong>$title</strong>, " >> index.html
        fi

        subtitle="$(grep "^#subtitle" $file | cut -d " " -f2-)"
        if [ ! -z "$subtitle" ]
        then
            echo "$subtitle, " >> index.html
        fi

        author="$(grep "^#author" $file | cut -d " " -f2-)"
        if [ ! -z "$author" ]
        then
            echo "<em>$author</em>" >> index.html
        fi

        echo "</a></div>" >> index.html
    fi
done
echo "</body></html>" >> index.html
rm -rf html
mkdir html
find  ./library -name '*.html' -exec cp -t ./html {} +
mv index.html ./html/index.html
cp ./assets/Anarchist_flag.svg ./html/Anarchist_flag.svg

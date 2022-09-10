rm -rf docs
rm -rf orig
wget \
     --recursive \
     --force-directories \
     --no-clobber \
     --page-requisites \
     --recursive \
     --html-extension \
     --convert-links \
     --backup-converted \
     --reject-regex=".*(Diskussion|action|Spezial|Benutzer.*oldid|Hauptseite.*oldid|title=.*oldid).*" \
     --domains ddos.odenwilusenz.ch \
         "http://ddos.odenwilusenz.ch/"

# missing.. no idea why..
wget \
     --force-directories \
     --page-requisites \
     --html-extension \
     --convert-links \
     --backup-converted \
     --domains ddos.odenwilusenz.ch \
         "http://ddos.odenwilusenz.ch/load.php?lang=de&modules=filepage%7Cmediawiki.action.view.filepage%7Cskins.vector.styles.legacy&only=styles&skin=vector"

mv ddos.odenwilusenz.ch docs
cp -r public/{.,}* docs

gsed -i 's/"wgRequestId":"[^"]*"/"wgRequestId":""/g' docs/*(.html|.orig)
gsed -i 's/"wgBackendResponseTime":[0-9]*/"wgBackendResponseTime":0/g' docs/*(.html|.orig)

for file in ./docs/*.html
do
  node index.js "$file"
done

# fix php title
gsed -i 's/index\.php.3Ftitle=//g' docs/*.html
rename 's/index\.php\?title=//;' docs/*.html

## fix svg
gsed -i 's/\.svg.3F...../.svg/g' ./docs/load.php* 

rename 's/\.svg\?.*/.svg/;' docs/**/*svg* 
mkdir ./orig/
mv ./docs/*orig ./orig/


prettier --write docs/*.html
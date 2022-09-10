rm -rf docs
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

mv ddos.odenwilusenz.ch docs
cp public/CNAME docs
cp public/.nojekyll docs

gsed -i 's/"wgRequestId":"[^"]*"/"wgRequestId":""/g' docs/*(.html|.orig)
gsed -i 's/"wgBackendResponseTime":[0-9]*/"wgBackendResponseTime":0/g' docs/*(.html|.orig)





for file in ./docs/*.html
do
  node index.js "$file"
done


## fix svg
gsed -i 's/\.svg.3F...../.svg/g' "./docs/load.php?lang=de&modules=skins.vector.styles.legacy&only=styles&skin=vector.css"
gsed -i 's/\.svg?...../.svg/g' "./docs/load.php?lang=de&modules=skins.vector.styles.legacy&only=styles&skin=vectororig"



rename 's/\.svg\?.*/.svg/;' docs/**/*svg* 





prettier --write docs/*.html
const filename = process.argv[2] || "docs/index.html";
const fs = require("fs");

const cheerio = require("cheerio");

const htmlString = fs.readFileSync(filename, "utf8");
const $ = cheerio.load(htmlString);

$("#right-navigation").remove();
$("#mw-head .vector-menu-content").remove();
$("#n-recentchanges").remove();
$("#n-randompage").remove();
$("#n-help-mediawiki").remove();
$("#p-tb").remove();
$("#footer-places").remove();
$("#footer-icons").remove();
$(".mw-editsection").remove();
$(".printfooter").remove();
$('link[type="application/x-wiki"]').remove();
$('link[type="application/rsd+xml"]').remove();
$('link[type="application/atom+xml"]').remove();
$('link[rel="edit"]').remove();
$(".mw-usertoollinks").remove();

$('script[src^="load.php"]').remove();

$('link[rel="stylesheet"][href^="http://ddos.odenwilusenz.ch/"]').each(
  function () {
    const orig = $(this).attr("href");
    console.log(`PARSE ${orig}`);

    $(this).attr("href", orig.replace("http://ddos.odenwilusenz.ch/", "").replace("?", "%3F").replace("skin=vector", "skin=vector.css"));
  }
);

$("a.new").each(function () {
  $(this).replaceWith($(this).text());
});

$('link[rel="shortcut icon"]').attr("href", "favicon.ico");

fs.writeFileSync(filename, $.html());

console.log(`${filename} processed`);

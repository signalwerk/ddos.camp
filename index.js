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
$('.mw-usertoollinks').remove();

$("a.new").each(function () {
  $(this).replaceWith($(this).text());
});

$('link[rel="shortcut icon"]').attr("href", "favicon.ico");

fs.writeFileSync(filename, $.html());

console.log(`${filename} processed`);

function getFiveLatestNews(xmlData){
  const DATA = $(xmlData);
  DATA.xpath("//item")
    .slice(0, 5)
    .each(function () {
      appendNewsToHTML($(this))
    });
}

function appendNewsToHTML(news){
  let title = news.find("title").text();
  let link = news.find("link").text();
  let description = news.find("description").text();
  
  let newsDiv =
    '<div class="news"><h1><a href=' +
    link +
    ' target="_blank">' +
    title +
    "</h1>" +
    description +
    "</a></div>";
  $(".newest").append(newsDiv);
}

function clearNewestHTML(){
  $(".newest").html("");
}

function searchNews(xmlData){
  $("#searchphrase").on("input", function(){
    const DATA = $(xmlData);
    var searchphrase = $(this).val();

    if(searchphrase){
       const NEWSES = DATA.xpath(
         "//item[title[contains(text(), '" + searchphrase + "')]]"
       );
      clearNewestHTML();
      NEWSES.each(function(){
        appendNewsToHTML($(this));
      })
    } else {
      clearNewestHTML();
      getFiveLatestNews(xmlData);
    }
  })
}

$(document).ready(function(){
  $.get(
    "https://cors-anywhere.herokuapp.com/https://tvn24.pl/najnowsze.xml",
    function (xmlData) {
      getFiveLatestNews(xmlData);
      searchNews(xmlData);
    }
  );
})
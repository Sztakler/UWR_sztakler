$(document).ready(function(){

  // const TEMPLATE = '<div class="news"><h1><a href="{{link}}" target="_blank">{{title}}</h1><img src="{{description.imageLink}}"></a><p>{{description.text}}</p></div>'
 const TEMPLATE = '<div class="news"><h1><a href="{{link}}" target="_blank">{{title}}</h1>{{{description.__cdata}}}</a></div>';
  $.getJSON("najnowsze.json", function(data){
    items = data.rss.channel.item
    
    for(let item of items.slice(0, 5)){
      /* 
        Zakomentowany kod to ręczne wycinanie adresu obrazka oraz opisu wiadomości
      */
      // let cdata = item.description.__cdata
      // cdataArr = cdata.split(">")
      // item.description.imageLink = cdataArr[0].slice(7).split('"')[1]
      // item.description.text = cdataArr[1].slice(6)
      $(".newest").append(Mustache.render(TEMPLATE, item))
    }
  })
})
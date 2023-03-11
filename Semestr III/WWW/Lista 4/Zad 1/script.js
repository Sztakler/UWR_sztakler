$(document).ready(function(){
    $("#searchphrase").on("input", function () {
        clearText()
        if ($(this).val().length >= 3) {
            $(".base").addClass("unmatched")
            var searchedPhrase = $(this).val()
            $(".base").each(function () {
            highlightText($(this), searchedPhrase)
            })
        }
        })
})

function highlightText(item, searchedPhrase){
    let itemHTML = item.html().replace(searchedPhrase, function(pattern){
        return $("<span>").addClass("highlighted").html(searchedPhrase)[0].outerHTML
    })

    if(itemHTML.includes(searchedPhrase)){
        item.removeClass("unmatched")
    }

    item.html(itemHTML)
}

function clearText(){
    $(".highlighted").replaceWith(function(){
        return $(this).html()
    })
    $(".base").removeClass("unmatched")
}

$(document).ready(function(){
     var adverbs = new Array(
       "appropriately",
       "assertively",
       "authoritatively",
       "collaboratively",
       "compellingly",
       "competently",
       "completely",
       "continually",
       "conveniently",
       "credibly",
       "distinctively",
       "dramatically",
       "dynamically",
       "efficiently"
     );

     var verbs = new Array(
       "actualize",
       "administrate",
       "aggregate",
       "architect",
       "benchmark",
       "brand",
       "build",
       "communicate",
       "conceptualize",
       "coordinate",
       "create",
       "cultivate",
       "customize",
       "whiteboard"
     );

     var adjectives = new Array(
       "24/7",
       "24/365",
       "accurate",
       "adaptive",
       "alternative",
       "an expanded array of",
       "B2B",
       "B2C",
       "backend",
       "backward-compatible",
       "best-of-breed",
       "bleeding-edge",
       "bricks-and-clicks",
       "business"
     );

     var nouns = new Array(
       "action items",
       "alignments",
       "applications",
       "architectures",
       "bandwidth",
       "benefits",
       "best practices",
       "catalysts for change",
       "channels",
       "collaboration and idea-sharing",
       "communities",
       "content",
       "convergence",
       "core competencies"
     );

    var columns = {
      "adverbs": adverbs,
      "verbs": verbs,
      "adjectives": adjectives,
      "nouns": nouns}

    for(let column of Object.keys(columns)){
        for (let row of columns[column]) {
          $(`#${column}`).append('<div class="row">' + row + "</div>")
        }
    }

    $("#button-generate").on("click", function(){
        var generatedSentence = ""
        for(let column_name of Object.keys(columns)){
            let column = columns[column_name]
            let word = column[Math.floor(Math.random() * column.length)]
            generatedSentence += word + " ";
        }

        $("#sentence-text").text(generatedSentence)
    })
})
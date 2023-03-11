$(document).ready(function(){


    $(".image").on("click", function(){
        selectImage($(this), $(this).data("marked"));
    })

    $("#select-all").on("click", function(){
        $(".image").each(function(){
            selectImage($(this), false);
        })
    })

    $("#unselect-all").on("click", function () {
      $(".image").each(function () {
        selectImage($(this), true);
      });
    });

    $("#write-to-log").on("click", function(){
         $("#log").text("")
         $(".image").each(function(){
            if($(this).data("marked")){
              $("#log").append(this.id + "\n");
            }
         })
    })
})

function selectImage(image, isSelected) {
  image.data("marked", !isSelected).toggleClass("image-selected", !isSelected);
}
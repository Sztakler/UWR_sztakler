squares = document.getElementsByName("loading_square");


function moveSquares(){
   
   
    for(let i = 0; i < squares.length; i++){
        let square = squares[i]
        setTimeout(() => {
            square.style.top = "150px";
        }, i * 100);
    }

    setTimeout(() => {
        for(let i = 0; i < squares.length; i++){
            let square = squares[i]
            setTimeout(() => {
                square.style.top = "200px";
            }, i * 100);
        }
    }, 600);
}

setInterval(() => {
    moveSquares()
}, 1400);


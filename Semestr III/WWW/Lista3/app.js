import { animate } from "popmotion"

animate({
    from: 0,
    to: 100,
    onUpdate: latest => console.log(latest)
    })
var TEMPLATE = '<div id="news1" class="news"><h1>Lorem Ipsum</h1><img src="https://i.picsum.photos/id/342/200/200.jpg?hmac=RWvP86WrI79J1lVaj-tfUFqvBHgAWnsRKVI9ER9Hdzc"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris at ipsum mauris. Sed non sapien scelerisque ante sodales gravida vel non purus. Proin at metus ultrices velit faucibus molestie vel id turpis. Donec commodo porttitor augue in commodo. Nullam quis neque tempus, elementum dolor mattis, imperdiet ligula. Integer et nisi faucibus ex euismod venenatis. Nulla malesuada dui dictum nibh feugiat, ut fermentum leo euismod. Mauris pretium lectus eu quam iaculis, et pulvinar leo luctus. Vivamus a mollis leo. Pellentesque sit amet egestas elit. Morbi eget viverra augue. Vestibulum volutpat gravida sagittis. </p></div>'

var DATA = {
    name: 'James Frost',
    title: 'Manager'
};

$.getJSON(
  "/home/krystian-jasionek/Studia Wrocław/Semestr III/WWW/Lista 5/Zadanie 2/zad2.json",
  function (data) {
    var items = [];
    $.each(data, function (key, val) {
      console.log(key, val);
    });
  }
);

console.log(Mustache.render(TEMPLATE, DATA))
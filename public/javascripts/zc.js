$(document).ready(function() {
  
  $('#arcadia').click(function() {
    var brand = "arcadia";
      alert(brand);
  });
  $('#becks').click(function() {
    var brand = "becks";
      alert(brand);
  });
  $('#budlight').click(function() {
    var brand = "budlight";
      alert(brand);
  });
  $('#coors').click(function() {
    var brand = "coors";
  });
  $('#corona').click(function() {
    var brand = "corona";
  });
  $('#guinness').click(function() {
    var brand = "guinness";
  });
  $('#heineken').click(function() {
    var brand = "heineken";
  });
  $('#keystone').click(function() {
    var brand = "keystone";
  });
  $('#labatt').click(function() {
    var brand = "labatt";
  });
  $('#miller').click(function() {
    var brand = "miller";
  });
  $('#rollingrock').click(function() {
    var brand = "rollingrock";
  });
  $('#samadams').click(function() {
    var brand = "samadams";
  });
  
  $('#searchboxxx').click(function() {
    $('#hidden').attr('value', brand); 
  });
  
});
private ["_imageText","_txt","_separator1"];
_separator1 = parseText "<br />";

for "_i" from 1 to 3 do {
  _imageText = parseText "<img size='12' color='#ff0000' image='images\shh.jpg'/>";

  _txt = composeText [_imageText,_separator1,"Your mouth is parched and lips too dry to continue whistling, try drinking something"];
  hintsilent _txt;
  sleep 0.4;

  _imageText = parseText "<img size='12' image='images\shh.jpg'/>";

  _txt = composeText [_imageText,_separator1,"Your mouth is parched and lips too dry to continue whistling, try drinking something"];
  hintsilent _txt;
  sleep 0.4;
};
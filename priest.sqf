_option = ((_this select 3) select 0);

switch (_option) do {
  case "jonna": {
    "Father Jonna" hintC format["Hello %1,  have you seen any young boys lately?", name player];
    sleep 0.1;
    hint "";
  };

  case "eli": {
    "Father Eli" hintC format["Hello %1, I have some popsicles in my cellar if you'd like one.", name player];
    sleep 0.1;
    hint "";
  };

  case "daniels": {
    "Father Daniels" hintC format["Hello %1, May God watch over your soul!", name player];
    sleep 0.1;
    hint "";
  };

  case "alacard": {
    "Father Alacard" hintC format["Beautiful day, isn't it, %1? It's especially beautiful if you're a soulless brute like yourself.", name player];
    sleep 0.1;
    hint "";
  };

  case "able": {
    "Father Able" hintC format["%1 have you seen that Romans guy lately? Hes a bad bad man...", name player];
    sleep 0.1;
    hint "";
  };

  case "jacobs": {
    "Father Jacobs" hintC format["%1, If it gets too hot and sweaty for you out here, feel free to take your shirt off.", name player];
    sleep 0.1;
    hint "";
  };
  case "kaleb": {
    "Father Kaleb" hintC format["%1, I hear those chickens out front cant be killed. They must be demons!!!", name player];
    sleep 0.1;
    hint "";
  };
  case "joseph": {
    "Father Joseph" hintC format["%1, You wouldnt believe it but today i got pull over by a cop on my way here and told to spread my legs and lift my sack. I love these new cops!", name player];
    sleep 0.1;
    hint "";
  };
};

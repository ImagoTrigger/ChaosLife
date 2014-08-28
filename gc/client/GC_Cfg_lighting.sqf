///// ZL Street Lights /////////
// "Land_PowLines_Conc2L_EP1" //
// "Land_Lamp_Street1_EP1"    //
// "Land_Lamp_Street2_EP1"    //
// "Land_Lamp_Small_EP1"      //
// "Land_Lampa_Ind_EP1"       //
////////////////////////////////

mjlight = getpos mdrugsell nearestObject "Land_Lamp_Small_EP1";
mjlight allowdamage false;
mjlight switchLight "ON";

// Helpful for knowing what streetlight you're near.
//arrlights = position player nearObjects ["streetlamp",10];
//obj = arrlights select 0;
//class = typeOf obj;
//player sidechat format ["%1",class];
//copyToClipboard (str (class));
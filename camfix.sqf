_cam = "camera" camCreate (position player);
_cam cameraEffect["internal","back"];
titleText["Fixing Screen","BLACK IN"];
titleFadeOut 5;
camUseNVG true;
sleep 0.5;
camUseNVG false;
_cam cameraEffect ["terminate","back"];
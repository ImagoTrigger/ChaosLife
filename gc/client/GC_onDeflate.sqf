_vcl = _this;
call compile format['
SFXPvEh_%2 = ["%3","deflateesfx"];
publicVariable "SFXPvEh_%2";
%1 say "deflateesfx";
',_vcl,rolenumber,rolestring];
[player,"head_hit",1] spawn GC_Blood;
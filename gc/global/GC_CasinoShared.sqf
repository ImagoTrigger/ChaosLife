GC_FNC_SumHand = {
  private ["_hand", "_sum", "_cardValue"];
  _hand = _this;
  _sum  = 0;

  {
    private ["_cardValue"];
    _cardValue = (_x call GC_FNC_CardValue);
    player groupChat format ["Card: %1 Value: %2", _x, _cardValue];
    _sum = _sum + _cardValue;
  } forEach _hand;

  _sum;
};

GC_ArrayAces   = [1,14,27,40];
GC_ArrayTwos   = [2,15,28,41];
GC_ArrayThrees = [3,16,29,42];
GC_ArrayFours  = [4,17,30,43];
GC_ArrayFives  = [5,18,31,44];
GC_ArraySixes  = [6,19,32,45];
GC_ArraySevens = [7,20,33,46];
GC_ArrayEights = [8,21,34,47];
GC_ArrayNines  = [9,22,35,48];
GC_ArrayTens   = [10,23,36,49];
GC_ArrayJacks  = [11,24,37,50];
GC_ArrayQueens = [12,25,38,51];
GC_ArrayKings  = [13,26,39,52];

GC_FNC_CardValue = {
  private ["_card", "_value"];
  _card = _this;
  _value = 0;

  if (_card in GC_ArrayAces) then   { _value = 1; };
  if (_card in GC_ArrayTwos) then   { _value = 2; };
  if (_card in GC_ArrayThrees) then { _value = 3; };
  if (_card in GC_ArrayFours) then  { _value = 4; };
  if (_card in GC_ArrayFives) then  { _value = 5; };
  if (_card in GC_ArraySixes) then  { _value = 6; };
  if (_card in GC_ArraySevens) then { _value = 7; };
  if (_card in GC_ArrayEights) then { _value = 8; };
  if (_card in GC_ArrayNines) then  { _value = 9; };

  if ((_card in GC_ArrayTens) or (_card in GC_ArrayJacks) or (_card in GC_ArrayQueens) or (_card in GC_ArrayKings)) then {
    _value = 10;
  };

  _value;
};
private["_v","_d","_colour","_pic"];
_v=_this select 0;
_d=_this select 1;
//if!((vehicle player)==_v)exitWith{};
if(_d<1)then{_d=1};
_d=ceil(_d/45);
_colour="#999999";
_pic=format["DAPS\Pics\d%1.paa",_d];
hint(parseText format["<img size='7' color='%1' img image='%2'/>%3",_colour,_pic," "]);
playSound"Alarm";
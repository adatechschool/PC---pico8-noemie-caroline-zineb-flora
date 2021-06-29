pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
p={x=60,y=60,speed=10}
end

function _update()
if (btn(➡️))p.x+=1
if (btn(⬅️))p.x-=1
if (btn(⬆️))p.y-=1
if (btn(⬇️))p.y+=1
end

function _draw()
cls(6)
map()
spr(1,p.x,p.y)
end

__gfx__
00000000a00bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a0ceb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000077ceb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700007717ceb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700077777ceb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070077777ceb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000007777ceb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000077ceb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddddddddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddd99dddddd0dddddd99dddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddd99dddddd0dddddd99dddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddddddddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddd99dddddd0dddddd99dddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddd99dddddd0dddddd99dddddd0d999d9999ddddddd0000000000000000000000000000000000000000000000000000000000000000
999d999d999d999d999d999d99dddddd0dddddd99dddddd0d999d9999ddddddd0000000000000000000000000000000000000000000000000000000000000000
999d999d999d999d999d999d99dddddd0dddddddddddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddddddddddd0dddddddddddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddddddddddd0dddddd99dddddd0ddddddd99ddddddd0000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0040414041404140414647000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0050515051505150515657000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000004445000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000005455000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000004445000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

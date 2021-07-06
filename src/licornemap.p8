pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--jeu des licornes
function _init()
	title_screen()
 create_player()
 enemies={}
 gen_enemies()
 friends={}
 gen_friends()
 sparkles={}
 rainbows={}
 gen_rainbow()
 scene="menu"
end

function _update()
 player_movement()
 check_flag()
 update_camera()
 enemy_movement()
 rainbow_movement()
 friends_movement()
 interact()
 for e in all(enemies)  do
  for s in all(sparkles) do
	  if hit(e,s) then 
	  del(sparkles,s)
   del(enemies,e)
   end
	 end
 end 
 end

function _draw()
	cls()
	draw_map()
	draw_player()
	for r in all(rainbows) do 
		spr(68,r.x*8,r.y*8)
	end
	for e in all(enemies) do 
		spr(70,e.x*8,e.y*8)
	end
	for f in all(friends) do
	 spr(69,f.x*8,f.y*8)
	end
	for s in all(sparkles) do
	spr(88,s.x*8,s.y*8)
 end
 draw_ui()
 
end

-->8
--map
function draw_map()
 map(0,0,0,0,128,64)
end

function check_flag(flag,x,y)
	local sprite = mget(x,y)	
	return fget(sprite, flag)
end	

function update_camera()
 local camx=mid(0,p.x-7,127-15)
	local camy=mid(0,p.y-7,5,63,15)
	camera(camx*8,camy*8)
end

--deux fonctions pour les keys
function next_tile(x,y)
	local sprite=mget(x,y)
 mset(x,y,sprite+1)

end

function pick_up_key(x,y)
 next_tile(x,y)
 p.keys+=1
 sfx(0)
end

-->8
--players
function create_player()
	p={x=2, y=9, sprite=65, speed=0.2,keys=0}
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function player_movement()
	newx=p.x
	newy=p.y
	
	if (btn(⬅️)) newx-=p.speed
	if (btn(➡️)) newx+=p.speed
	if (btn(⬆️)) newy-=p.speed
	if (btn(⬇️)) newy+=p.speed
	if (btnp(❎)) shoot()
	update_sparkles()
	
	
	interact(newx,newy)
	
	if not check_flag(0,newx,newy) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,64)
	else
		sfx(1)
	end
end

--permet de rcup les keys
function interact(x,y)
 if check_flag(1,x,y) then
  pick_up_key(x,y)
 end
end












-->8
--enemies  
function gen_enemies()
	new_enemy={x=14,y=5, speed=0.2, sens=1,axe="v"}
	ne={x=22,y=16, speed=0.1, sens=1,axe="h"}
 add(enemies,new_enemy)
 add(enemies,ne)
 
end

function enemy_movement() 
 for e in all(enemies) do
	newx=e.x
	newy=e.y
	if e.axe=="v" then
	newy+=e.sens*e.speed
	e.y=newy
	else 
	newx+=e.sens*e.speed
	e.x=newx
	end
	if check_flag(0,newx,newy) then
	e.sens*=-1
 e.x=newx
	e.y=newy
	end
	end
end
	
	
-->8
--friends
--enemies  
function gen_friends()
	new_friend={x=10,y=10, speed=1, sens=0.05,axe="h"}
--	ne={x=22,y=16, speed=1, sens=0.1,axe="h"}
 add(friends,new_friend)
end

function friends_movement() 
 for f in all(friends) do
	newx=f.x
	newy=f.y
	if f.axe=="v" then
	newy+=f.sens
	f.x=newx
	f.y=newy
	else 
	newx+=f.sens
	f.x=newx
	f.y=newy
	end
	if check_flag(0,newx,newy) then
		f.sens*=-1
 f.x=newx
	f.y=newy
	end
	
	end 
end
	
	
-->8
--bullets
function shoot()
 new_sparkle={
 x=p.x,
 y=p.y,
 speed=0.5}
	add(sparkles, new_sparkle)
	sfx(0)
 end	
 
 function update_sparkles()
  for s in all (sparkles) do
  s.x+=s.speed
  end
 end
 
 function hit(e,s)
 	if e.x > s.x+1
 	or e.y > s.y+1
 	or e.x+1  < s.x
 	or e.y+1 < s.y then
 	 return false
 	else
 	 return true
 	end
 end 
-->8
--rainbow
function gen_rainbow()
	new_rainbow={x=14,y=5, speed=0.2, sens=1,axe="v"}
	nr={x=22,y=16, speed=0.1, sens=1,axe="h"}
 add(rainbows,new_rainbow)
 add(rainbows,nr)
 
end

function rainbow_movement() 
 for r in all(rainbows) do
	newx=r.x
	newy=r.y
	if r.axe=="v" then
	newy+=r.sens*r.speed
	r.y=newy
	else 
	newx+=r.sens*r.speed
	r.x=newx
	end
	if check_flag(0,newx,newy) then
	r.sens*=-1
 r.x=newx
	r.y=newy
	end
	end
end
-->8
--title screen

function title_screen()
    while not btn(4) and  not btn(5) do 
        rectfill(0,0,127,127,0)
        rectfill(16,24,104,64,0)
        map(0,0,0,8,22,22)
        color(7)
        cursor(22,80)
        print("press ❎ to start",30,81)
        print("press ⬅️➡️⬆️⬇️ to move",20,90)
        flip()
    end 
end


-->8
--ui
function draw_ui()
 camera()
 palt(0,false)
 palt(12,true)
	spr(176,2,1)
	print_outline("X"..p.keys,10,2)
 palt()
end

function print_outline(text,x,y)
 print(text,x-1,y,0)
	print(text,x+1,y,0)
	print(text,x,y-1,0)
	print(text,x,y+1,0)
	print(text,x,y,7)
end
__gfx__
00000000000000000000000000000000000000003333333333333333000000005555555555555555555555555555555533333333333333333333333333333333
000000000000000000000000555555555555500033333333a3a33333000000005555555555555555555555559555555577777777777773337777777777777333
0070070000000000000000005666666666666000333333333933a3a3000000005555555555555555555555559555555576666666666663337666666666666333
000770000000000000000000566666666666600033333333a3a33933000000005555555555555555555555555555555576696966996663337996699696669333
0007700000000000000000005666666666666000333333333333a3a3000000005555555555555555555555559555555576699969669663337969696969696333
0070070000000000000000005666666666666000333333333a3a3333000000005555555555555555555555559555555576696969999663337999699966966333
00000000000000000000000056666666666660003333333333933333000000005555555555555555555555555555555576696969669663337966696666966333
0000000000000000000000005666666666666000333333333a3a3333000000005555555555555555555555559555555576666666666663337666666666666333
00000000000000000000000055555555555550000000000000000000000000009959959955555555555555559555555577777777777773337777777777777333
00000000777777777777700055555555555550000000000000000000000000005555555555555555555555555555555577777777777773337777777777777333
00000000766666666666600055555555555550000000000000000000000000005555555595555555555555559555555577777777777773337777777777777333
00000000766666666666600066666666666660000000000000000000000000005555555595555555555555559555555566666666666663336666666666666333
00000000766666666666600066666666666660007777777777777000000000005555555555555555555555555555555566666666666663336666666666666333
00000000766666666666600066666666666660007666666666666000000000005555555595555555555555559555555566666666666663336666666666666333
00000000766666666666600066776677667760007666666666666000000000005555555595555555555555559555555566aa66bb66ee6333668866bb66226333
00000000766666666666600066776677667760007666666666666000000000005555555555555555555555555555555566aa66bb66ee6333668866bb66226333
00000000777777777777700066666666666660007777777777777000555555555555555555555555555555559555555566666666666663336666666666666333
00000000777777777777700066666666666660006666666666666000cccccccc5555555555555555555555555555555566666666666663336666666666666333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555559555555566666666666663336666666666666333
00000000667766776677600066776677667760006677667766776000111111115555555555555555555555559555555566dd669966ee633366dd669966ee6333
00000000667766776677600066776677667760006677667766776000111111115555555555555555555555555555555566dd669966ee633366dd669966ee6333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555559555555566666666666663336666666666666333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555559555555566666666666663336666666666666333
000000006677667766776000667766776677600066776677667760001111111155555555555555555555555555555555662266dd66aa6333662266dd66aa6333
000000006677667766776000667766776677600066776677667760001111111199599599599599599959959955555555662266dd66aa6333662266dd66aa6333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555555555555566666666666663336666666666666333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555555555555566666666666663336666666666666333
00000000667766776677600066776677667760006677667766776000111111115555555555555555555555555555555566ee66cc66bb633366ee66cc66bb6333
00000000667766776677600066776677667760006677667766776000111111115555555555555555555555555555555566ee66cc66bb633366ee66cc66bb6333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555555555555566666666666663336666666666666333
00000000666666666666600066666666666660006666666666666000111111115555555555555555555555555555555566666666666663336666666666666333
00000000667766776677600066666666666660006677667766776000111111115555555555555555555555555555555566666666666663336666666666666333
000a00000000a00000aae000000eaa000a0000a00000000000000000000000000000000000000000000000000000000000000000555555559555555500000000
0eab00000000bae0000a77000077a00000a00a000010010000800800000000000000000000000000000000008888888888888000555555555555555500000000
77a000bbbb000a770007c700007c700000aeea0000ffff0000111100000000000000000000000000000000008666666666666000555555559555555500000000
7c700bebbeb007c7bb077f0000f770bb00c77c0000f11f000018810000e0000000c7c80000000000000000008666666666666000555555559555555500000000
f77777ebbe77777fee770000000077ee077777700ffffff0011111100a7c0000007c780000000000000000008666666666666000555555555555555500000000
077777ebbe777770e07770000007770e007ff70000ffff000011110000b0000000c7c80000000000000000008666666666666000555555559555555500000000
070007e00e700070e070f000000f070e00b00b0000f00f0000100100000000000000000000000000000000008666666666666000555555559555555500000000
0f000f0000f000f000f0000000000f000fb00bf007f00f7001100110000000000000000000000000000000008666666666666000555555555555555500000000
000a0000000000000000000000000000000000000000066666600000000000000000000000000000000000008888888888888000555555555995995900000000
00aa100000000000000000000000a00000000000006666666666660000000000a00a000a00000000000000008888888888888000555555555555555500000000
0aabee0000000000000000000000aa0000000000066685666658666000000000000aa00000000000000000008888888888888000555555555555555500000000
0abbbee0000000000000000000eeeaa000000000066688666688666000000000007ee70000000000000000006666666666666000555555555555555500000000
0777bbee00000000000000000eebbba0000000000066666d56666600000000000aebcea000000000000000006666666666666000555555555555555500000000
07077bee0000000000000000eebb77700000000000066665d666600000000000007ee70000000000000000006666666666666000555555555555555500000000
77777bee0000000000000000eeb7707000000000000066666666000000000000000aa00000000000000000006600660066006000555555555555555500000000
77777bee0000000000000000eeb7777700000000000006688660000000000000a000a00a00000000000000006600660066006000555555555555555500000000
ff777bee00000ee00ee00000eeb77777000000000000006666000000000000000000000055555555555555556666666666666000555555555555555500000000
000777ee0000eeeeeeee0000eeb777ff00000000000000066000000000000000000ee00055555555555555556666666666666000555555555555555500000000
0007777e7777beebbeeb7777ee7770000000000000000006600000000000000000eaae0055555555555555556666666666666000555555555555555500000000
000777777777bbbbbbbb7777e7777000000000666666666666666666660000000eaccae055555555555555556600660066006000555555555555555500000000
00077777777770bbbb0777777777700000000066666666666666666666000000eac77cae55555555555555556600660066006000555555555555555500000000
000777777777700bb00777777777700000000066000006cccc600000660000000eaccae055555555555555556666666666666000555555555555555500000000
000777000077700000077700007770000000006600000666cc6000006600000000eaae0055555555555555556666666666666000555555555555555500000000
000ccc0000ccc000000ccc0000ccc000000000660000066cc660000066000000000ee00055555555555555556600660066006000555555555555555500000000
0000000000000000000000000000000000000066000006cc66600000660000000000000099599599599599596600660066006000555555555995995900000000
0000000000000000000000000000000000000866800006cccc600008668000000000000055555555555555556666666666666000555555555555555500000000
0000000000000000000000000000000000000080000006666660000008000000aaa0000055555555555555556666666666666000555555559555555500000000
0000000000000000000000000000000000000000000006666660000000000000a0aaaaaa55555555555555556600660066006000555555559555555500000000
0000000000000000000000000000000000000000000006666660000000000000aaa00a0a55555555555555556600660066006000555555555555555500000000
00000000000000000000000000000000000000000000066886600000000000000000000a55555555555555556666666666666000555555559555555500000000
00000000000000000000000000000000000000000000066666600000000000000000000055555555555555556666688666666000555555559555555500000000
00000000000000000000000000000000000000000006666666666000000000000000000055555555555555556666688666666000555555555555555500000000
dddddddddddddddd7070707070707070707070700006666666666000000000000000000000000000000000007070707070707070707070707070707070707000
dddddddddddddddd0000000000000000000000000006600000066000888888888888888888888888888888880000000000000000000000000000000000000000
ddddd9dddddddddd0000000000000000000000000006600000066000866666666666666666666666666666680000000000000000000000000000000000000000
d9999d9ddddddddd0000000000000000000000000006600000066000800000606666060000606660600006680000000000000000000000000000000000000000
49444944444444440000000000000000000000000006600000066000866660600666060666606660606666680000000000000000000000000000000000000000
44444444444444440000000000000000000000000006600000066000866606606066060006606660600006680000000000000000000000000000000000000000
d222222dd222222d0000000000000000000000000086600000066800866066606606060666606060677706680000000000000000000000000000000000000000
dddddddddddddddd0000000000000000000000000086600000066800860666606660060666600600666606680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000800000606666060000606660600006680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000866666666666666666666666666666680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000866666666666666666666666666666680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000866666666666666666666666666666680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000866666666666666666666666666666680000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000888888888888888888888888888888880000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000888888888888888888888888888888880000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000888888888888888888888888888888880000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000666666666666666666666666666666660000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600060006000600060006000600060060000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600060006000600060006000600060060000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600060006000600060006000600060060000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000666666666666666666666666666666660000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600060006000600060006000600060060000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000600060006000600060006000600060060000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000666666666666666666666666666666660000000000000000000000000000000000000000
cccccccc000000000000000000000000000000000000000000000000600060006008888888888000600060060000000000000000000000000000000000000000
cc0ccccc000000000000000000000000000000000000000000000000600060006008888888888000600060060000000000000000000000000000000000000000
c0a0000c000000000000000000000000000000000000000000000000600060006008877997788000600060060000000000000000000000000000000000000000
0a0aaaa0000000000000000000000000000000000000000000000000666666666668877997788666666666660000000000000000000000000000000000000000
c0a000a0000000000000000000000000000000000000000000000000600000000668877997788660000000060000000000000000000000000000000000000000
cc0ccc0c000000000000000000000000000000000000000000000000600000000668877007788660000000060000000000000000000000000000000000000000
cccccccc000000000000000000000000000000000000000000000000600000000688877997788860000000060000000000000000000000000000000000000000
cccccccc000000000000000000000000000000000000000000000000600000000688877997788860000000060000000000000000000000000000000000000000
__gff__
0001210101000000000000000101010101212101010101000000000001010101010101010101010100000000010101010101010101010101000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000201000000000000
0200000000000001010101000000000000000000000000010101010000000000000000000000000101010100000000000000000000000001050501000000000000000000000000000404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0102030401020304010203010203040707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112131411121314111213111213140707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2122232421222324212223212223241715160707070715160707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3132333431323334313233313233340125262526252625260707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707010135363536353635360707070102030407070707070707070705050707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01020304070701020304070707076d6e28292829282908090715161112131415160707070705050505050507070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11121314151611121314151607077d7e383938393839181980252621222324252607070707050c0d0e0f0505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21222324252621222324252625260a0b0102030415160a0b01020304323334353607070707051c1d1e1f0505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
31323334353631323334353635361a1b1112131425261a1b11121314070707072727272705052c2d2e2f0505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6a696a6a6a6a6a292829282928292a2b2122232435360a0b21222324072727273737373705053c3d3e3f0505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7a797a7a7a7a7a7a7a7a7a397a7a3a3b3132333407071a1b3132333407373737373737370605050505050505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
151601020304151601800304151601000304272727070a0b0707010201028788898a0606060506050c0d0e0f070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
252611121314252611121314252611121314010203041a1b1516111211129798999a0606060505051c1d1e1f070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
353621222324353621222324353621222324111213140a0b252621222122a7a8a9aa0606060605052c2d2e2f070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
070731323334070731323334270731323334212223241a1b353631323132b7b8b9ba8006060606053c3d3e3f070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
072727070707272727272727370707070707313233344d4e282928292829282928292829696a060605050505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
273737272727373707070707070707070707070715165d5e383938393839383938393839797a060606050505070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707252615161516151607070707070707060606060c0d0e0f05070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070725262526252607070707070707060606061c1d1e1f05070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707060605052c2d2e2f05070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707050505053c3d3e3f05070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000005050090500e050120501a0501f05023050260502a0502d0502f0503005031050310503105031050310502e0502b0502205019050140500f0500b05008050060500605007050090500c0501205016050
0010000008150131501a150241502a1502d15031150331503515037150381503815038150381503815038150381503d1502a1502f1502e1502d1502c150281502615023150211501a150111500f1502d15000000
001000000f2500f2500f2501125011250112502225025250292502d2502e250322503325034250342503425032250000002d25028250242501e25019250122500c2500b2500f25011250152501b2502025025250
__music__
00 01020344


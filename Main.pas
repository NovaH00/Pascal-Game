program Game;
uses crt;
var point, difficulty: integer;
    ch: char;
    user_input: string;

    player_pos: array[1..2] of integer;
    player_notation: char;

    enemy1_pos, enemy2_pos, enemy3_pos, enemy4_pos: array[1..2] of integer;
    enemy_notation: char;

    food_pos: array[1..2] of integer;
 

procedure draw(pos_x, pos_y: integer; notation: char);
begin
  gotoxy(pos_x, pos_y);
  write(notation);
  
end;

procedure draw_board();
var i: integer;
begin
  for i := 1 to 60 do 
  begin
    
    if(i>=2) then
    begin
      draw(i, 1, '-');
      draw(i, 21, '-');
    end;

    if(i <= 21) then 
    begin
      draw(1, i, '|');
      draw(61, i, '|');
    end;

  end;

end;

procedure draw_board2();
begin
  gotoxy(1,1);
  write('-----------------------------------------------------------');
  gotoxy(1, 21);
  write('-----------------------------------------------------------');

end;

function x_dir_restriction(x_pos: integer): integer;
begin
  if (x_pos > 1 ) and (x_pos < 59) then x_dir_restriction := x_pos;
  if (x_pos < 2) then x_dir_restriction := 2;
  if (x_pos > 58) then x_dir_restriction := 58;
end;

function y_dir_restriction(y_pos: integer): integer;
begin
  if (y_pos > 1 ) and (y_pos < 21) then y_dir_restriction := y_pos;
  if (y_pos < 2) then y_dir_restriction := 2;
  if (y_pos > 20) then y_dir_restriction := 20;
end;

function enemyX_move(enemy_x_pos, player_x_pos, move_step: integer): integer;
begin

  if (enemy_x_pos < player_x_pos) then enemyX_move := enemy_x_pos + random(move_step);
  if (enemy_x_pos > player_x_pos) then enemyX_move := enemy_x_pos - random(move_step);
  if (enemy_x_pos = player_x_pos) then enemyX_move := enemy_x_pos;
end;

function enemyY_move(enemy_y_pos, player_y_pos, move_step: integer): integer;
begin
  if (enemy_y_pos < player_y_pos) then enemyY_move := enemy_y_pos + random(move_step);
  if (enemy_y_pos > player_y_pos) then enemyY_move := enemy_y_pos - random(move_step);
  enemyY_move := enemy_y_pos;
end;

function is_collide(enemy_x_pos, enemy_y_pos, player_x_pos, player_y_pos: integer): boolean;
begin
  if(enemy_x_pos = player_x_pos) and (enemy_y_pos = player_y_pos) then is_collide := True
  Else is_collide := False;
end;

procedure main();
begin
  clrscr;
  randomize;

  

  writeln('Nhap do kho tu 1 den 4');
  readln(difficulty);
  while (difficulty < 1) or (difficulty > 4) do
  begin
    writeln('Khong hop le, do kho tu 1 den 4');
    readln(difficulty);
  end;  
  difficulty := difficulty + 1;
  
  writeln('Hay an bat ky phim mui ten de choi');
  writeln('An [ESC] de bo cuoc');
  
  //Player
  player_pos[1] := 10;
  player_pos[2] := 5;
  player_notation := '0';

  point := 0;

  //Enemy
  enemy_notation := '#';
  enemy1_pos[1] := random(20) + 30;
  enemy1_pos[2] := random(5) + 10;

  enemy2_pos[1] := random(20) + 35;
  enemy2_pos[2] := random(5) + 10;
  
  enemy3_pos[1] := random(20) + 35;
  enemy3_pos[2] := random(5) + 10;

  enemy4_pos[1] := random(20) + 40;
  enemy4_pos[2] := random(5) + 10;
  
  //Food
  food_pos[1] := random(57) + 2;
  food_pos[2] := random(18) + 2;



  repeat
    ch:=ReadKey;
    case ch of
     #0 : begin
            ch:=ReadKey; {up: H; down: P, left: K, right: M}
            //up
            if(ch = 'H') then player_pos[2] := player_pos[2] - 1;
            //down
            if(ch = 'P') then player_pos[2] := player_pos[2] + 1;
            //left
            if(ch = 'K') then player_pos[1] := player_pos[1] - 1;
            //right
            if(ch = 'M') then player_pos[1] := player_pos[1] + 1;
            
            //Code start here
            clrscr;
            // draw_board();
            // draw_board2();

            //map restrict
            player_pos[1] := x_dir_restriction(player_pos[1]);
            player_pos[2] := y_dir_restriction(player_pos[2]);

            enemy1_pos[1] := x_dir_restriction(enemy1_pos[1]);
            enemy1_pos[2] := y_dir_restriction(enemy1_pos[2]);
            
            enemy2_pos[1] := x_dir_restriction(enemy2_pos[1]);
            enemy2_pos[2] := y_dir_restriction(enemy2_pos[2]);
            
            enemy3_pos[1] := x_dir_restriction(enemy3_pos[1]);
            enemy3_pos[2] := y_dir_restriction(enemy3_pos[2]);
            
            enemy4_pos[1] := x_dir_restriction(enemy4_pos[1]);
            enemy4_pos[2] := y_dir_restriction(enemy4_pos[2]);

            //Enemy move

            //Lựa chọn bất kỳ theo hướng x hoặc y

            if (random(2) = 0) then 
            begin

              enemy1_pos[1] := enemyX_move(enemy1_pos[1], player_pos[1], difficulty);            
              enemy2_pos[1] := enemyX_move(enemy2_pos[1], player_pos[1], difficulty);              
              enemy3_pos[1] := enemyX_move(enemy3_pos[1], player_pos[1], difficulty);              
              enemy4_pos[1] := enemyX_move(enemy4_pos[1], player_pos[1], difficulty);
              
            end

            Else
            begin

              enemy1_pos[2] := enemyX_move(enemy1_pos[2], player_pos[2], difficulty);
              enemy2_pos[2] := enemyX_move(enemy2_pos[2], player_pos[2], difficulty);             
              enemy3_pos[2] := enemyX_move(enemy3_pos[2], player_pos[2], difficulty);             
              enemy4_pos[2] := enemyX_move(enemy4_pos[2], player_pos[2], difficulty);
              
            end;
          
            //draw
            draw(food_pos[1], food_pos[2], '@');
            draw(player_pos[1], player_pos[2], player_notation);

            draw(enemy1_pos[1], enemy1_pos[2], enemy_notation);
            draw(enemy2_pos[1], enemy2_pos[2], enemy_notation);
            draw(enemy3_pos[1], enemy3_pos[2], enemy_notation);
            draw(enemy4_pos[1], enemy4_pos[2], enemy_notation);

            
            //Collide with enemy check
            if (is_collide(enemy1_pos[1], enemy1_pos[2], player_pos[1], player_pos[2])) then break;
            if (is_collide(enemy2_pos[1], enemy2_pos[2], player_pos[1], player_pos[2])) then break;
            if (is_collide(enemy3_pos[1], enemy3_pos[2], player_pos[1], player_pos[2])) then break;
            if (is_collide(enemy4_pos[1], enemy4_pos[2], player_pos[1], player_pos[2])) then break;
            
            //Collide with food
            if (is_collide(food_pos[1], food_pos[2], player_pos[1], player_pos[2])) then
            begin
              point := point + 1;
              food_pos[1] := random(57) + 2;
              food_pos[2] := random(18) + 2;
            end;

            //di chuyển con trỏ về vị trí 1,1
            gotoxy(1,1);
            write('Points: ',point);
          end;

    end;
    
  until ch=#27 {Esc}
end;

begin
  clrscr;
  writeln('Ban la |0| dang co gang thu thap |@| nhung ke dich |#| muon ngan can ban');
  writeln('An bat ky nut nao do de tiep tuc');
  readln();
  repeat
    main();
    clrscr;
    writeln('Ban da thua');
    writeln('Diem cua ban la: ', point);
    writeln('Nhap bat ky de choi lai, [n] de dung');
    readln(user_input);
  until user_input = 'n';
end.

program flybird;

uses GraphABC;

type
  point = record
    x, y: integer;
  end;

var
  Left, Right, Up, Down, i, x, y, chet: integer;
  cloud, bird, background, plane, sun, boom, planekill, clear, planeground: picture;
  menublackground: picture;
  clouds: array[1..5] of point;
  birds: array[1..5] of point;
  game, active, booom, story, final: boolean;
  vx: array[1..5] of integer;

procedure KeyDown(Key: integer);
begin
  if Key = vk_Up then Up := 1;
  if Key = vk_Down then Down := 1;
  if Key = vk_Right then Right := 1;
  if Key = vk_Left then Left := 1;
  if Key = vk_Escape then game := false;
  if Key = vk_Escape then booom := false;
  if Key = vk_Escape then story := false;
  if Key = vk_Escape then final := false;
end;

procedure KeyUp(Key: integer);
begin
  if Key = vk_Up then Up := 0;
  if Key = vk_Down then Down := 0;
  if Key = vk_Right then Right := 0;
  if Key = vk_Left then Left := 0;
end;

procedure MouseUp(x, y, mb: integer);
begin
  if  (mb = 1) and (x > 50) and (x < 350)  and (y > 490) and (y < 570) then game := true;
  if  (mb = 1) and (x > 50) and (x < 350)  and (y > 690) and (y < 770) then active := false;
  if  (mb = 1) and (x > 50) and (x < 350)  and (y > 590) and (y < 670) then story := true;
  if  (mb = 1) and (x > 1100) and (x < 1400) and (y > 750) and (y < 850) then booom := false;                                                                              //1100,750,1400,850
end;

begin
  lockdrawing;
  setwindowsize(1440, 900);
  window.Caption := 'Born To Fly';
  window.IsFixedSize := true;
  window.CenterOnScreen;
  OnKeyUp := KeyUp;
  OnKeyDown := KeyDown;
  OnMouseUp := MouseUp;
  
  
  plane := picture.Create('data\plane.png');
  background := picture.Create('data\background.png');
  cloud := picture.Create('data\cloud.png');
  bird := picture.Create('data\bird.png');
  sun := picture.Create('data\sun.png');
  boom := picture.Create('data\boom.png');
  planekill := picture.Create('data\planekill.png');
  menublackground := picture.Create('data\menubackground.png');
  clear := picture.Create('data\clear.png');
  planeground := picture.Create('data\planebackground.png');
  
  
  game := false;
  active := true;
  booom := false;
  story := false;
  
  
  while active do
  begin
    chet := 0;
    clearwindow;
    x := 100;
    y := 450;
    
    vx[1] := 15;
    vx[2] := 19;
    vx[3] := 20;
    vx[4] := 17;
    vx[5] := 18;
    
    
    
    //========================Начальные координаты птиц=======================
    
    for i := 1 to 5 do                             
    begin
      birds[i].x := 1440;                       
      birds[i].y := random(850);                
    end;
    
    //==========================================================================
    
    
    
    
    
     //================Координаты облачков=================
    for i := 1 to 5 do               
      clouds[i].y := 730;          
    
    clouds[1].x := 250;          
    clouds[2].x := 550;          
    clouds[3].x := 850;         
    clouds[4].x := 1200;         
    clouds[5].x := 1440;          
    //=======================================================
    
    
    
    
    
     //============MENU==============================
    Setbrushstyle(bssolid);
    menublackground.Draw(0, 0);
    setbrushcolor(clGreen);
    SetFontColor(Clblack);
    SetPenColor(clblack);
    setFontsize(40);
    
    Rectangle(50, 490, 350, 570);
    TextOut(80, 500, 'Полететь');
    
    SetBrushColor(ClYellow);
    Rectangle(50, 590, 350, 670);
    TextOut(90, 600, 'История');
    
    SetBrushColor(Clgray);
    Rectangle(50, 690, 350, 770);
    TextOut(100, 700, 'Выход');
    
    setfontsize(50);
    Setbrushstyle(bsclear);
    SetFontColor(clPurple);
    TextOut(50, 410, 'Born To Fly');
    
    redraw;
    //==============================================
    
    //======================Story====================
    
    while story do
    begin
      clear.Draw(0, 0);
      redraw;
    end;
    //=====================Story=====================
    
    
    
    
    
    //Тут начинается игра
    while game do
    begin
      
      background.Draw(0, 0);
      sun.Draw(5, 5);
      plane.Draw(x, y);
      
      setfontcolor(clblue);
      setfontsize(30);
      textout(0,825,chet);
      
      for i := 1 to 5 do bird.Draw(birds[i].x, birds[i].y);
      for i := 1 to 5 do cloud.Draw(clouds[i].x, clouds[i].y);
      
      if Left = 1 then x := x - 10;           
      if Right = 1 then x := x + 10;          
      if Down = 1 then y := y + 10;          
      if Up = 1 then y := y - 10;             
      
      //=======================Скорость птичек===============================
      for i := 1 to 5 do
        
        birds[i].x := birds[i].x - vx[i];                       
      
      //====================================================================
      
      
      
      
      
      //========================Скорость облаков============================
      for i := 1 to 5 do                       
        clouds[i].x := clouds[i].x - 3;    
      
      //===================================================================== 
      
      
      
      
      
       //=====================Передвижение птичек и облаков , если x<0==================
      for i := 1 to 5 do                                
      begin
        if birds[i].x + 50 < 0 then                     
        begin
          birds[i].y := random(850);                       
          birds[i].x := 1440;         
          chet := chet + 1;
          vx[i] := vx[i] + 1;
          
          
        end;                                            
      end;                                               
      
      for i := 1 to 5 do                                
      begin
        if clouds[i].x + 300 < 0 then                  
        begin
          clouds[i].y := 750;                      
          clouds[i].x := 1440;                    
        end;                                    
      end;  
      
      //===============================================================================
      
      
      
      
      
      
      
      //=======================Boom============================
      for i := 1 to 5 do
      begin
        if (x + 70 > birds[i].x ) and
           (x < birds[i].x + 50 ) and
           (y < birds[i].y + 50 ) and
           (y + 62 > birds[i].y)
        then
        begin
          boom.Draw(x - 30, y - 20);                                                           
          booom := true;
        end;
        while booom do
        begin
          chet := 0;
          redraw;   
          game := false;
          sleep(1000);                                       
          planekill.Draw(0, 0);                               
          setfontsize(30);                                      
          setbrushstyle(bsclear);                            
          setFontColor(clBlack);                              
          TextOut(100, 700, 'Вы не смогли добраться ');      
          TextOut(100, 750, 'До');                          
          SetFontColor(ClBlue);                            
          TextOut(160, 750, 'Пункта Назначения');
          
          SetFontColor(clgreen);
          setfontsize(30);
          setbrushcolor(clyellowgreen);
          setpencolor(clred);
          setbrushstyle(bssolid);
          rectangle(1100, 750, 1400, 850);
          textout(1111, 775, 'Главное Меню');
          
        end;
        
      end;
      //============================Boom============================
      
      
      
      
      
      //===========================Final============================
      if chet = 100 then  begin final := true; end;    //Количество птиц
      while final do
      begin
        planeground.Draw(0, 0);
        redraw;
        
      end;
      //============================================================
      
      
      
      
      redraw;    
    end; //Тут заканчивается игра
  end;
  Halt;
end.
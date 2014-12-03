function [] = testProgram(correctBygg, correctHus)

% img=imread('pictures/Bygg_1.png');    % OK - med tre punkter
% procent(1,1) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1');
% img=imread('pictures/Bygg_1a.png');   % OK - med tre punkter
% procent(1,2) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1a');
% img=imread('pictures/Bygg_1b.png');   % OK - med tre punkter
% procent(1,3) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1b');
% img=imread('pictures/Bygg_1c.png');   % OK - med tre punkter
% procent(1,4) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1c');
% img=imread('pictures/Bygg_1d.png');   % N?stanm- med tre punkter
% procent(1,5) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1d');
% img=imread('pictures/Bygg_1e.png');   % Nope - f?rvr?ngd, 4punkter?
% procent(1,6) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 1e');
% img=imread('pictures/Bygg_2.png');    % OK - med tre punkter
% procent(1,7) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2');
% img=imread('pictures/Bygg_2a.png');   % V?ldigt n?ra
% procent(1,8) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2a');
% img=imread('pictures/Bygg_2b.png');   % OK - med tre punkter
% procent(1,9) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2b');
% img=imread('pictures/Bygg_2c.png');   % OK- med tre punkter
% procent(1,10) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2c');
% img=imread('pictures/Bygg_2d.png');   % OK - med tre punkter
% procent(1,11) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2d');
% img=imread('pictures/Bygg_2e.png');   % Nope - f?rvr?ngd, 4punkter?
% procent(1,12) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 2e');
% img=imread('pictures/Bygg_3.png');    % OK - med tre punkter
% procent(1,13) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3');
% % img=imread('pictures/Bygg_3_Illum.png'); 
% % procent(1,14) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% img=imread('pictures/Bygg_3a.png');   % OK - med tre punkter
% procent(1,14) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3a');
% img=imread('pictures/Bygg_3b.png');   % OK - med tre punkter
% procent(1,15) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3b');
% img=imread('pictures/Bygg_3c.png');   % OK - med tre punkter
% procent(1,16) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3c');
% img=imread('pictures/Bygg_3d.png');   % OK - med tre punkter
% procent(1,17) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3d');
% img=imread('pictures/Bygg_3e.png');   % Nope - Flyttas ur bild
% procent(1,18) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3e')

% procent
% Final = sum(procent(:,:))/18


% img=imread('pictures/Hus_1.png');    % Bra ib?rjan, en till punkt
% procentHus(1,1) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1');
% img=imread('pictures/Hus_1a.png'); 
% procentHus(1,2) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1a');
% img=imread('pictures/Hus_1b.png'); 
% procentHus(1,3) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1b');
% img=imread('pictures/Hus_1c.png'); 
% procentHus(1,4) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1c');
% img=imread('pictures/Hus_1d.png'); 
% procentHus(1,5) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1d');
% img=imread('pictures/Hus_1e.png'); 
% procentHus(1,6) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 1e');
% img=imread('pictures/Hus_2.png'); 
% procentHus(1,7) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2');
% img=imread('pictures/Hus_2a.png'); 
% procentHus(1,8) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2a');
% img=imread('pictures/Hus_2b.png'); 
% procentHus(1,9) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2b');
% img=imread('pictures/Hus_2c.png'); 
% procentHus(1,10) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2c');
% img=imread('pictures/Hus_2d.png'); 
% procentHus(1,11) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2d');
% img=imread('pictures/Hus_2e.png'); 
% procentHus(1,12) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 2e');
% img=imread('pictures/Hus_3.png'); 
% procentHus(1,13) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3');
% img=imread('pictures/Hus_3a.png'); 
% procentHus(1,14) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3a');
% img=imread('pictures/Hus_3b.png'); 
% procentHus(1,15) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3b');
% img=imread('pictures/Hus_3c.png'); 
% procentHus(1,16) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3c');
% img=imread('pictures/Hus_3d.png'); 
% procentHus(1,17) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3d');
% img=imread('pictures/Hus_3e.png'); 
% procentHus(1,18) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 3e');
% img=imread('pictures/Hus_4.png');  
% procentHus(1,19) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4');
% img=imread('pictures/Hus_4a.png'); 
% procentHus(1,20) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4a');
% img=imread('pictures/Hus_4b.png'); 
% procentHus(1,21) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4b');
% img=imread('pictures/Hus_4c.png'); 
% procentHus(1,22) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4c');
% img=imread('pictures/Hus_4d.png');
% procentHus(1,23) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4d');
% img=imread('pictures/Hus_4e.png'); 
% procentHus(1,24) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4e');
% img=imread('pictures/Husannons_full.png'); 
% procentHus(1,25) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus husannons_full');
% 
% procentHus
% Final = sum(procentHus(:,:))/22


% img=imread('pictures/Bygg_3_Illum.png'); 
% procentIllum(1,1) = 100*(sum(eq(correctBygg, tnm034(img)))/50);
% disp('klar med bygg 3 Illum');
img=imread('pictures/Hus_1_Illum.png'); 
procentIllum(1,2) = 100*(sum(eq(correctHus, tnm034(img)))/183);
disp('klar med hus 1 Illum');
% img=imread('pictures/Hus_4_Illum.png'); 
% procentIllum(1,3) = 100*(sum(eq(correctHus, tnm034(img)))/183);
% disp('klar med hus 4 Illum');

procentIllum
Final = sum(procentIllum(:,:))/3


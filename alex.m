 
load('Answer_Bygg.mat');
load('Answer_DostojevskyMetro.mat');
load('Answer_Hus.mat');
 
packs = { 'Bygg', 'Hus', 'DostojevskyMetro' };
 
for p = packs
    files = dir(['./', p{1}, '/*.png']);
    score_accum = 0;
    time_accum = 0;
 
    fprintf('\nRunning suite: %s\n', p{1});
 
    N = length(files);
    for n = 1:N
        current = ['./', p{1}, '/', files(n).name];
        img = imread(current);
        fprintf('Image: %s... ', current);
        tic;
        str = tnm034(img);
 
        score = sum(str == eval(p{1}))/(length(str))*100;
        time_elapsed = toc;
        fprintf('%.2f %% (%.2f s)\n', score, time_elapsed);
 
        time_accum = time_accum + time_elapsed;
        score_accum = score_accum + score;
    end
 
    score_accum = score_accum/N;
    fprintf('Overall suite score: %.2f %% (%.2f s)\n', score_accum, time_accum);
end
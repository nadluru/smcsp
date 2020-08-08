clear
close all;
IMPath = 'C:\yxw\CVPR 2011\jigsawCode\jigsawCode\Results\ParticleIteration\ImNo_6_PatchSize_56\noFixInd_1\';

nFrames = 107;

mov(1:nFrames) = struct('cdata', [],...
                        'colormap', []);

for k = 1:107
    ims = imread(strcat(IMPath,'Iter_',num2str(k),'.bmp'));
    imshow(ims);axis equal;
    mov(k) = getframe(gcf);
end
movie(mov);
movie2avi(mov, strcat(IMPath,'Movie.avi'),'fps',2,'quality',50);
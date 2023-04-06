%

chdir(fullfile(vistaRootPath,'local','GariFigures'))

load('sampleImages.mat','B');
B = double(B);

% imtool(B(:,:,1));
thisB = B(:,:,1) - mean(mean(B(:,:,1)));
thisB = log10(fftshift(abs(fft2(thisB))));
% imagesc(thisB);
colormap('hot');

mrvNewGraphWin;
thisB(thisB<2) = 0;
mesh(thisB);

% imtool(B(:,:,4));
thisB = B(:,:,4) - mean2(B(:,:,4));

thisB = log10(fftshift(abs(fft2(thisB))));
% imagesc(thisB);
mrvNewGraphWin;
thisB(thisB<2) = 0;
mesh(thisB);
colormap('hot');

thisB = randn(1024,1024);
thisB = fftshift(abs(fft2(thisB)));
% imagesc(thisB);
thisB(thisB<2) = 0;
mesh(thisB);


%%
foo = load('ES_RW_tr-0.8_duration-300sec_size-1024pix_maxEcc-9deg_barWidth-2deg');
foo.stimulus
mrvNewGraphWin;
for ii=1:size(foo.stimulus.images,3)
    imshow(foo.stimulus.images(:,:,ii));
    pause(0.05);
end

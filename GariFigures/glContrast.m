% Analyze the statistics of the images Gari is using
%
%  sampleImages are sample images
%  ES_RW_tr-0.8_duration-300sec_size-1024pix_maxEcc-9deg_barWidth-2deg,
%    are the stimulus shown in the scanner
%
% Build a calculation of pRF so that a change in the spatial
% statistics of the image might shift the center of the population
% receptive field.
%

%% Gari's sample images for display

% But this is already where we are.  It will be useful when there is a
% new repository.
chdir(fullfile(vistaRootPath,'local','GariFigures'))

%% There are four images
load('sampleImages.mat','B');
B = double(B);
mrvNewGraphWin;
montage(B)



% imtool(B(:,:,1));
thisB = B(:,:,1) - mean(mean(B(:,:,1)));
thisB = log10(fftshift(abs(fft2(thisB))));
imagesc(thisB);
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


%% Movie of the stimulus
load('ES_RW_tr-0.8_duration-300sec_size-1024pix_maxEcc-9deg_barWidth-2deg','stimulus');

mrvNewGraphWin;
for ii=1:size(stimulus.images,3)
    imshow(stimulus.images(:,:,ii));
    pause(0.05);
end


%  Script to verify relationship between the auto-correlation matrix
%  and the fast fourier transform of a template x
%  Based on slides by Prof. Simon Lucey at 
%  http://16623.courses.cs.cmu.edu/slides/Lecture_14.pdf
%  Author: Esha Uboweja (euboweja)

% Get template to track
im = im2double(imread('./TasmanianTiger.jpg'));

% Grab rectangle from user
% figure; imshow(im); title('Draw a rectangle on the object');
% rect = getrect;
% save('./tigerFaceRect.m','rect');

% load rectangle for the face
load('./tigerFaceRect.mat');
x = im(rect(2):rect(2)+rect(4), rect(1):rect(1)+rect(3));

% Show selected template
figure('Name', 'Selected template', 'NumberTitle', 'off');;
imshow(im);
hold on;
rectangle('Position', rect, 'EdgeColor', 'r', 'LineWidth', 3)
print('./tigerFace', '-dpng');

% Show some examples of circular shifts
fprintf('Displaying examples of circular shifts...');
xshift1 = circshift(x, [20, 20]);
xshift2 = circshift(x, [-20, -20]);
xshift3 = circshift(x, [100, 100]);
xshift4 = circshift(x, [-100, -100]);
xshift5 = circshift(x, [150, 150]);
figure('Name', 'Examples of Circular Shifts', 'NumberTitle', 'off');
subplot(2,3,1); imshow(x); title('x[0,0]');
subplot(2,3,2); imshow(xshift1); title('x[20,20]');
subplot(2,3,3); imshow(xshift2); title('x[-20,-20]');
subplot(2,3,4); imshow(xshift3); title('x[100,100]');
subplot(2,3,5); imshow(xshift4); title('x[-100,-100]');
subplot(2,3,6); imshow(xshift5); title('x[150, 150]');
print('./tigerFaceCircShift', '-dpng');
fprintf('Done!\n');

% Generate auto-correlation matrix
fprintf('Computing auto-correlation matrix S...');
[h, w] = size(x);
[X, Y] = meshgrid(-w:w, -h:h);
locs = [X(:), Y(:)];
S = zeros(size(x, 1), size(x, 1));
for i=1:size(locs, 1)
    v = circshift(x, locs(i, :));
    S = S + (v * v');
end
fprintf('Done!\n');

% See if the eigenvectors of S diagnalize S
fprintf('Eigen-decomposition of S...');
[U, D, V] = eig(S);
M = U' * S * U;
figure('Name', 'U = eigenvectors of auto-correlation matrix S', 'NumberTitle', 'off');
imagesc(U); title('U = eigenvectors of auto-correlation matrix S');
print('./S_eigenvectors_M', '-dpng');
figure('Name', 'M = U^T * S * U', 'NumberTitle', 'off');
imshow(M); title('M = U^T * S * U');
imwrite(M, './S_eigDiagonalized.png');
fprintf('Done!\n');

% Get the FFT of x
fprintf('FFT of x...');
F = fft(x);
figure('Name', 'FFT of x', 'NumberTitle', 'off');
imshow(F); title('FFT of x');
imwrite(F, './fft_x.png');
fprintf('Done!\n');

% Is the FFT of (x) = Eigenvectors of S?
fprintf('FFT(x) == eigenVectors(S)? : %d\n', all(F(:) == U(:)));



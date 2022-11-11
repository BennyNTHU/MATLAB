function houghMatViz(H,T,R)
figure
% Convert the hough matrix to a grayscale image
Hgray = mat2gray(H);
% Enhance its brightness
Hgray = imadjust(Hgray);

imshow(Hgray,'XData',T,'YData',R,'InitialMagnification','fit');
hold on
% turn on the axis
axis on 
% adjusts the aspect ratio of the axes and the relative scaling of the
% data units so that the plot fits the figure's shap
axis normal 
% assign a colormap for the image 
colormap(hot);title('Hough Transform');
% add x-y labels
xlabel('\theta')
ylabel('\rho');
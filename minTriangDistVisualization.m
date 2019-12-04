clear
close all
clc

%% init
% Create 2 random triangles
T1 = randn(1,9);
T2 = randn(1,9);

%% plot
% plot T1 (Red)
x = T1(1:3:end);
y = T1(2:3:end);
z = T1(3:3:end);
Tri = [1,2,3];

figure
trisurf(Tri,x,y,z,'FaceColor',[1,0,0],'FaceAlpha',0.5,'EdgeColor','k')
hold on

% plot T2 (Green)
x = T2(1:3:end);
y = T2(2:3:end);
z = T2(3:3:end);
Tri = [1,2,3];

trisurf(Tri,x,y,z,'FaceColor',[0,1,0],'FaceAlpha',0.5,'EdgeColor','k')

xlabel('x')
ylabel('y')
zlabel('z')
legend('T1','T2')

%% distance
[d,p1,p2] = simdTriTri2(T1,T2);

% Plot shortest segment connecting the two triangles
plot3([p1(1),p2(1)], [p1(2),p2(2)], [p1(3),p2(3)], 'b', 'DisplayName', 'min. dist')
hold off

title(sprintf('Dist = %.2f', d))
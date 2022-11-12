I=imread("26.jpg");
[R,G,B]=imsplit(I);

%color compensation

r=mean(R,"all");
g=mean(G,"all");
b=mean(B,"all");
Bc=B+(((r+g)/2-b)/(r+g+b))*(R+G+B);
Gc=G+((r-g)/(r+g+b))*(R+G+B);
I2(:,:,1)=R;
I2(:,:,2)=Gc;
I2(:,:,3)=Bc;
r=mean(R,"all");
g=mean(Gc,"all");
b=mean(Bc,"all");

%white balancing

k=(r+g+b)/3;
Rcw=(k/r)*R;
Gcw=(k/g)*Gc;
Bcw=(k/b)*Bc;
I3(:,:,1)=Rcw;
I3(:,:,2)=Gcw;
I3(:,:,3)=Bcw;
subplot(2,2,1);
imshow(I);
title("Input Image");
subplot(2,2,2);
imshow(I2);
title("color compensated Image");
subplot(2,2,3);
imshow(I3);
title("white Balanced");

%rgb2hsv

I4=rgb2hsv(I3);
[h,s,v]=imsplit(I4);

%clahe

v1=adapthisteq(v);

% streching saturation

[M,N]=size(s);
s1=zeros(M,N);
for i=1:M
    for j=1:N
        s1(i,j)=(1/(1+exp(1-s(i,j))));
    end
end
I5(:,:,1)=h;
I5(:,:,2)=(s1+s)/2;
I5(:,:,3)=v1;
%hsv2rgb
I6=hsv2rgb(I5);
subplot(2,2,4);
imshow(I6);
title("Enhanced Image");


% Practica #6.1 Filtro Pasa Baja
% Flores Numa Jefte Allfadir
% 2011640201

clc
clear all
close all

%% Lectuta imagen
[file,root]=uigetfile('*.jpg','Selecciona Imagen');
IMA=imread(strcat(root,file));

%% Indice de creaci�n de m�scara
mask=ones(3,3);
mask=(1/9)*mask;

%% Conversi�n imagen a escala de grises
GRIS=rgb2gray(IMA);

%% Tama�o imagen
[NF,NC]=size(GRIS);

%% Ruido a la imagen
a=input('Seleccione 1 para ruido Gausiano o 2 para ruido Sal & Pimienta:\n');
if a==1
    IMruido=double(imnoise(GRIS,'gaussian',0.1));
elseif a==2
    IMruido=double(imnoise(GRIS,'salt & pepper',0.1));
else
    h=msgbox('Valor Incorrecto','Error','error');
    break
end

%% Aplicando el filtrado
GRIS2=zeros(NF+2,NC+2); %Matr�z donde se amplia el tama�o del marco
IMfiltrada=zeros(NF,NC); %Matr�z resultante del filtrado

%% Igualando matriz de ruido a la matriz donde se amplia el marco
for i=1:NF
    for j=1:NC
        GRIS2(i+1,j+1)=IMruido(i,j);
    end
end

%% Aplicando el filtro pasa bajas
for i=2:NF+1
    for j=2:NC+1
        IMfiltrada(i,j)=sum(sum(mask.*[GRIS2(i-1,j-1) GRIS2(i-1,j) GRIS2(i-1,j+1); GRIS2(i,j-1) GRIS2(i,j) GRIS2(i,j+1); GRIS2(i+1,j-1) GRIS2(i+1,j) GRIS2(i+1,j+1)]));
    end
end

figure(1)
subplot(2,2,1), imshow(IMruido/255), title('Imagen con ruido')
subplot(2,2,2), imshow(GRIS2/255), title('Imagen con marco ampliado')
subplot(2,2,3), imshow(GRIS), title('Gris Original')
subplot(2,2,4), imshow(IMfiltrada/255), title('Gris Filtrada')
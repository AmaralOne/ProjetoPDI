function [X_train, Y_train,X_test,Y_test] = x(qtd_classes,qtd_fotos,porcertagem_teste)
X_train = [];
Y_train = [];
X_test = [];
Y_test = [];
aux = ceil(qtd_fotos*(1-porcertagem_teste));
for j = 1:qtd_classes
    %1º parâmetro: endereço da pasta de imagens
    file = strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\N2-1\pca\orl_faces','\s');  % COLOQUE O ENDEREÇO !!!!
   
    filename = strcat(file,int2str(j));
    cd(filename)
    for k = 1:qtd_fotos
        x = imread(strcat(int2str(k),'.pgm'));
        y = reshape(x,[size(x,1)*size(x,2),1]);
        if( k <= aux)
            X_train = [X_train , y];
            Y_train = [Y_train, j];
        else
            X_test = [X_test , y];
            Y_test = [Y_test, j];
        end
        
    end
end
%X_train = transpose(X_train);
%X_test = transpose(X_test);
%Y_train = transpose(Y_train);
%Y_test = transpose(Y_test);
end
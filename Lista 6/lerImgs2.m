function [X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = x(qtd_classes,qtd_fotos,porcertagem_teste,boolCaracteristicas)
X_train = [];
Y_train = [];
X_test = [];
Y_test = [];
X_train_aux = [];
X_teste_aux = [];
aux = ceil(qtd_fotos*(1-porcertagem_teste));
qtd_fotos_teste = ceil(qtd_fotos*(porcertagem_teste));
w = 1;
b = 1;
for j = 1:qtd_classes
    %1� par�metro: endere�o da pasta de imagens
    %file = strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo','\s');  % COLOQUE O ENDERE�O !!!!
    file = strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\emocao2','\s');  % COLOQUE O ENDERE�O !!!!
    filename = strcat(file,int2str(j));
    cd(filename)
    for k = 1:qtd_fotos
        x = imread(strcat(int2str(k),'.tiff'));
        r = randi([1 qtd_fotos],1,qtd_fotos_teste,'single');
        
        teste = 0;
        for m = 1:qtd_fotos_teste
            if(k == r(m))
                teste = 1;
            end
        end
        
        if(boolCaracteristicas == 1)       
            y = extractHOGFeatures(x,'CellSize',[16 16]);
            s = reshape(x,[size(x,1)*size(x,2),1]);   
            if( teste == 1) 
                X_teste_aux = [X_teste_aux , s];
                Y_test = [Y_test, j];
                X_test(w, :) = y;
                w = w +1;
            else
             
                X_train_aux = [X_train_aux , s];
                Y_train = [Y_train, j];
                X_train(b, :) = y;
                b = b+1;
            end
        else    
            y = reshape(x,[size(x,1)*size(x,2),1]);
            if( teste == 0)
                X_train = [X_train , y];
                Y_train = [Y_train, j];
            else
                X_test = [X_test , y];
                Y_test = [Y_test, j];
            end
        end
        
    end
end
if(boolCaracteristicas == 1)
    X_train = transpose(X_train);
    X_test = transpose(X_test);
end
end
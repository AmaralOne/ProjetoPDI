function [X_train,Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = x(qtd_classes,qtd_fotos,porcertagem_teste,typeExtratorDeCaracteristicas,caminho,cellSize,bag)
X_train = [];
Y_train = [];
X_test = [];
Y_test = [];
X_train_aux = [];
X_teste_aux = [];
aux = ceil(qtd_fotos*(1-porcertagem_teste));
w = 1;
b = 1;

for j = 1:qtd_classes
    %1º parâmetro: endereço da pasta de imagens

    file =  caminho;
    cd(file);

    for k = 1:qtd_fotos
        x = strcat(int2str(k),'.jpg');
        if(k < 10)
            x = strcat('0',x); 
        end
        x = strcat('-',x);
        x = strcat(int2str(j),x);
        x = imread(x);
        x = imresize(x,0.5);
        x = rgb2gray(x);
        
        if(typeExtratorDeCaracteristicas == 1)% SURF
            y = encode(bag, x); % feature vector.
            y = y';
            s = reshape(x,[size(x,1)*size(x,2),1]);
            if( k <= aux) 
                X_train_aux = [X_train_aux , s];
                Y_train = [Y_train, j];
                X_train = [X_train, y];
            else
                X_teste_aux = [X_teste_aux , s];
                Y_test = [Y_test, j];
                X_test = [X_test, y];
            end
            
        elseif(typeExtratorDeCaracteristicas == 2) % HOG      
            y = extractHOGFeatures(x,'CellSize',cellSize);
            s = reshape(x,[size(x,1)*size(x,2),1]);
            if( k <= aux) 
                X_train_aux = [X_train_aux , s];
                Y_train = [Y_train, j];
                X_train(b, :) = y;
                b = b+1;
            else
                X_teste_aux = [X_teste_aux , s];
                Y_test = [Y_test, j];
                X_test(w, :) = y;
                w = w +1;
            end
        else    
            y = reshape(x,[size(x,1)*size(x,2),1]);
            if( k <= aux)
                X_train_aux = [X_train_aux , y];
                X_train = [X_train , y];
                Y_train = [Y_train, j];
            else
                X_test = [X_test , y];
                Y_test = [Y_test, j];
            end
        end
        
    end
end
if(typeExtratorDeCaracteristicas == 2)
    X_train = transpose(X_train);
    X_test = transpose(X_test);
end
end
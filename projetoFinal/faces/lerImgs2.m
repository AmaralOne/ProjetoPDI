function [X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = x(qtd_classes,qtd_fotos,porcertagem_teste,boolCaracteristicas,caminho,cellSize,bag)
X_train = [];
Y_train = [];
X_test = [];
Y_test = [];
X_train_aux = [];
X_teste_aux = [];
aux = ceil(qtd_fotos*(1-porcertagem_teste));
qtd_fotos_teste = (qtd_fotos - ceil(qtd_fotos*(1-porcertagem_teste)));
w = 1;
b = 1;
h = fspecial('average',[4 4]);
%r = randi([1 qtd_fotos],1,qtd_fotos_teste,'single');
r = randperm(qtd_fotos,qtd_fotos_teste);
qtd_fotos_teste
r
for j = 1:qtd_classes
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
        B = imfilter(x,h);
        B = imadjust(B,[],[],0.5); % Gamma correction.
        x = imresize(B,0.5);
        %faceDetector = vision.CascadeObjectDetector;
        %bboxes = faceDetector(x);
        %x = imcrop(x,[65 1 200 210]);
        x = imcrop(x,[50 0 220 240]);
        %x = imcrop(x,bboxes);
        x = rgb2gray(x);
        
        teste = 0;
        for m = 1:qtd_fotos_teste
            if(k == r(m))
                teste = 1;
            end
        end
        
        if(boolCaracteristicas == 2)       
            y = extractHOGFeatures(x,'CellSize',cellSize);
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
        elseif(boolCaracteristicas == 1)
            y = encode(bag, x); % feature vector.
            y = y';
            s = reshape(x,[size(x,1)*size(x,2),1]);
            if( teste == 0) 
                X_train_aux = [X_train_aux , s];
                Y_train = [Y_train, j];
                X_train = [X_train, y];
            else
                X_teste_aux = [X_teste_aux , s];
                Y_test = [Y_test, j];
                X_test = [X_test, y];
            end
        else
            y = reshape(x,[size(x,1)*size(x,2),1]);
            if( teste == 0)
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
if(boolCaracteristicas == 2)
    X_train = transpose(X_train);
    X_test = transpose(X_test);
end
end
file = strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo','\s1');  % COLOQUE O ENDEREÇO !!!!
cd(file)
x = imread('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo\s1\10.tiff');
figure();imshow(x);
i = isfile('500.tiff');

[train, test] = crossvalind ('HoldOut',Groups,0.2); 

%% teste
k = 8

r = randi([1 qtd_fotos],1,qtd_fotos_teste,'single')
        
        teste = 0;
        for m = 1:qtd_fotos_teste
            if(k == r(m))
                teste = 1;
            end
        end
        
        teste
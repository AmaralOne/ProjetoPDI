file = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\projetoFinal\faces\individuos';  % COLOQUE O ENDEREÇO !!!!
cd(file)
x = imread('71-13.jpg');
figure();imshow(x);


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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galvão - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all

Questao = 4;

cellSize = [4 4];
if(Questao == 1)
    qtd_classes = 7;
    qtd_fotos = 20;
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\emocao2';
elseif(Questao == 2)
    qtd_classes = 10;
    qtd_fotos = 14;
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo';
elseif(Questao == 3)
    qtd_classes = 7;
    qtd_fotos = 20;
    typeExtratorDeCaracteristicas = 2;
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\emocao2';
    cellSize = [44 44];
else
    qtd_classes = 10;
    qtd_fotos = 14;
    typeExtratorDeCaracteristicas = 2;
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo';
    cellSize = [16 16];
end
    
%% Ler o Comjunto de Treinamento e Teste

porcertagem_teste = 0.3;

[X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs(qtd_classes,qtd_fotos,porcertagem_teste,typeExtratorDeCaracteristicas,caminho,cellSize);
cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6') % COLOQUE O ENDEREÇO !!!!

%% Gerar a PCA com o conjunto de treinamento
[P PC mn] = GerarPCs(X_train);


%% Avaliar o Conjunto de Teste
i= 1;
c = size(Y_test,2);
preditc_teste = [];
while(i <= c)
    x = X_test(:,i);
    d = Classificar(PC, ProjetarAmostra(x,mn,P,0));
    preditc_teste = [preditc_teste Y_train(d)];
    
    i = i + 1;
end


acuracia = sum(preditc_teste == Y_test)/length(Y_test)*100;
disp("Acuracia Total:"+acuracia);

C = confusionmat(Y_test,preditc_teste);
%figure();
%cm = confusionchart(C);
acuraciaPorClasse = [];
qtd_fotos_teste = (qtd_fotos - ceil(qtd_fotos*(1-porcertagem_teste)));
for linha= 1:qtd_classes
    for coluna= 1:qtd_classes
        if(linha == coluna)        
            aux = C(linha,coluna)/qtd_fotos_teste;
            acuraciaPorClasse(linha) = aux*100;
        end    
    end
end
for linha= 1:qtd_classes
    disp ("classe "+linha+": "+acuraciaPorClasse(linha)+" %");   
end

%% Testar Indivíduos separadamente
i = 1;
while(i)
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: 's1\12.tiff'
   if(im == 0)
       break;
   end
   %1º parâmetro: endereço da pasta de imagens
   x = imread(strcat(caminho,strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   aux_x = ProjetarAmostra(x,mn,P,typeExtratorDeCaracteristicas);
   d = Classificar(PC, aux_x);
   figure;
   imshowpair(reshape(X_train_aux(:,d),256,256),x,'montage')
   
   clear im, clear x, clear d
    
end
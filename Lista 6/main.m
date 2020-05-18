%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galv�o - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all

Questao = 2;

cellSize = [4 4];
if(Questao == 1)
    qtd_classes = 7;
    qtd_fotos = 20;
    %caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\emocao2';
    typeExtratorDeCaracteristicas = 1;
    caminho = 'C:\Users\Gideon\Desktop\PUC\Graduacao\9� Per�odo\CMP1084 - Processamento Digital de Imagens\N2\Listas de exerc�cios\Lista 6\emocao2';
    imds = imageDatastore(caminho,'IncludeSubfolders',true,'FileExtensions','.tiff');
    bag = bagOfFeatures(imds,'StrongestFeatures',1,'PointSelection','Detector');
elseif(Questao == 2)
    qtd_classes = 10;
    qtd_fotos = 14;
    typeExtratorDeCaracteristicas = 1;
    %caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo';
    caminho = 'C:\Users\Gideon\Desktop\PUC\Graduacao\9� Per�odo\CMP1084 - Processamento Digital de Imagens\N2\Listas de exerc�cios\Lista 6\Individuo';
    imds = imageDatastore(caminho,'IncludeSubfolders',true,'FileExtensions','.tiff');
    bag = bagOfFeatures(imds);
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

[X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs(qtd_classes,qtd_fotos,porcertagem_teste,typeExtratorDeCaracteristicas,caminho,cellSize,bag);
%cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6') % COLOQUE O ENDERE�O !!!!
cd('C:\Users\Gideon\Desktop\PUC\Graduacao\9� Per�odo\CMP1084 - Processamento Digital de Imagens\N2\Listas de exerc�cios\Lista 6')

% [X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs3(qtd_classes,qtd_fotos,porcertagem_teste,caminho);

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

%% Testar Indiv�duos separadamente
i = 1;
while(i)
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: 's1\12.tiff'
   if(im == 0)
       break;
   end
   %1� par�metro: endere�o da pasta de imagens
   x = imread(strcat(caminho,strcat('\',im)));   % COLOQUE O ENDERE�O !!!!
   aux_x = ProjetarAmostra(x,mn,P,typeExtratorDeCaracteristicas,bag);
   d = Classificar(PC, aux_x);
   figure;
   imshowpair(reshape(X_train_aux(:,d),256,256),x,'montage')
   
   clear im, clear x, clear d
    
end
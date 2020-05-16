%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galvão - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all

qtd_classes = 7;
qtd_fotos = 20;

porcertagem_teste = 0.3;
boolCaracteristicas = 0;

[X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs2(qtd_classes,qtd_fotos,porcertagem_teste,boolCaracteristicas);
cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6') % COLOQUE O ENDEREÇO !!!!

[P PC mn] = GerarPCs(X_train);

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
acuracia

%%Um resumo de linha normalizado de linha exibe as porcentagens de observações classificadas correta e incorretamente para cada classe verdadeira. Um resumo da coluna normalizado da coluna exibe
%%as porcentagens de observações classificadas correta e incorretamente para cada classe prevista.
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
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: 's39\3.pgm'
   if(im == 0)
       break;
   end
   %1º parâmetro: endereço da pasta de imagens
   %x = imread(strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\Individuo',strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   x = imread(strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\Lista6\emocao2',strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   aux_x = ProjetarAmostra(x,mn,P,2);
   d = Classificar(PC, aux_x);
   figure;
   imshowpair(reshape(X_train_aux(:,d),256,256),x,'montage')
   
   clear im, clear x, clear d
    
end
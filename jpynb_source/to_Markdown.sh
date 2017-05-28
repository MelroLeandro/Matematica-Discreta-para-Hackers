%
% Shell script para converter ipynb em makdown
%

cd ./Chapter1_Introducao/ && ipython nbconvert Chapter1_Introducao.ipynb --to markdown
cd ../Chapter2_Calculo_Proposicional/ && ipython nbconvert Chapter2_Calculo_Proposicional.ipynb --to markdown
cd ../Chapter3_Deducao_Natural/ && ipython nbconvert Chapter3_Deducao_Natural.ipynb --to markdown
cd ../Chapter4_Logica_de_predicados/ && ipython nbconvert Chapter4_Logica_de_predicados.ipynb --to markdown
cd ../Chapter5_Teoria_de_conjuntos/ && ipython nbconvert Teoria_de_conjuntos.ipynb --to markdown
cd ../Chapter6_Python/ && ipython nbconvert Chapter6_Python.ipynb --to markdown
%cd ../Chapter7_Ordens_Equivalencia/ && ipython nbconvert Chapter7_Ordens_Equivalencia.ipynb --to markdown
cd ../Chapter8_Estruturas_Algebricas/ && ipython nbconvert Chapter8_Estruturas_Algebricas.ipynb --to markdown
%cd ../Chapter9_Gramaticas_Automatos/ && ipython nbconvert Chapter9_Gramaticas_Automatos.ipynb --to markdown
cd ../Chapter10_PyGame/ && ipython nbconvert Chapter10_PyGame.ipynb --to markdown
%cd ../Chapter11_TeoriaGrafos/ && ipython nbconvert Chapter11_TeoriaGrafos.ipynb --to markdown

#
# Shell script para converter ipynb em makdown
#

cd ./jpynb_source/Chapter1_Introducao/ && ipython nbconvert Chapter1_Introducao.ipynb --to markdown
cd ./jpynb_source/Chapter2_Calculo_Proposicional/ && ipython nbconvert Chapter2_Calculo_Proposicional.ipynb --to markdown
cd ./jpynb_source/Chapter3_Deducao_Natural/ && ipython nbconvert Chapter3_Deducao_Natural.ipynb --to markdown
cd ./jpynb_source/Chapter4_Logica_de_predicados/ && ipython nbconvert Chapter4_Logica_de_predicados.ipynb --to markdown
cd ./jpynb_source/Chapter5_Teoria_de_conjuntos/ && ipython nbconvert Teoria_de_conjuntos.ipynb --to markdown
cd ./jpynb_source/Chapter6_Python/ && ipython nbconvert Chapter6_Python.ipynb --to markdown
cd ./jpynb_source/Chapter7_Ordens_Equivalencia/ && ipython nbconvert Chapter7_Ordens_Equivalencia.ipynb --to markdown
cd ./jpynb_source/Chapter8_Estruturas_Algebricas/ && ipython nbconvert Chapter8_Estruturas_Algebricas.ipynb --to markdown
cd ./jpynb_source/Chapter9_Gramaticas_Automatos/ && ipython nbconvert Chapter9_Gramaticas_Automatos.ipynb --to markdown
cd ./jpynb_source/Chapter10_PyGame/ && ipython nbconvert Chapter10_PyGame.ipynb --to markdown
cd ./jpynb_source/Chapter11_TeoriaGrafos/ && ipython nbconvert Chapter11_TeoriaGrafos.ipynb --to markdown
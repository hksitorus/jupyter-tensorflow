ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER


RUN pip install --quiet \
    plotly yellowbrick folium

RUN pip install --quiet \
    gensim spacy nltk textblob stanfordcorenlp wordcloud

RUN conda install --quiet --yes basemap pyproj proj4

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
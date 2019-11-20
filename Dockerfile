ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER


RUN pip install --quiet \
    plotly yellowbrick folium

RUN pip install --quiet \
    gensim spacy nltk textblob stanfordcorenlp wordcloud

RUN conda install --quiet --yes basemap pyproj proj4

RUN wget https://raw.githubusercontent.com/matplotlib/basemap/master/lib/mpl_toolkits/basemap/data/epsg -O /opt/conda/share/proj/epsg

ENV PROJ_LIB=/opt/conda/share/proj/

USER root
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nodejs && \
    rm -rf /var/lib/apt/lists/*
ENV NODE_OPTIONS=--max-old-space-size=4096
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build
RUN jupyter labextension install plotlywidget@1.3.0 --no-build
RUN jupyter labextension install jupyterlab-plotly@1.3.0 --no-build
RUN jupyter lab build
USER $NB_UID

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
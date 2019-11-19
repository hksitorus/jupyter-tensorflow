ARG BASE_CONTAINER=jupyter/tensorflow-notebook
FROM $BASE_CONTAINER

RUN pip install --quiet \
    'plotly yellowbrick folium' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
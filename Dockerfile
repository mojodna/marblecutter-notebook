FROM jupyter/scipy-notebook

MAINTAINER Seth Fitzsimmons <seth@mojodna.net>

USER root

RUN conda install --yes -c conda-forge \
  gdal=2.2.* \
  arrow=0.10.* \
  boto3 \
  cachetools \
  haversine \
  psycopg2 \
  shapely \
 && conda remove --quiet --yes --force qt pyqt \
 && conda clean -tipsy

RUN conda install --yes -c conda-forge -p $CONDA_DIR/envs/python2 python=2.7 \
  gdal=2.2.* \
  arrow=0.10.* \
  boto3 \
  cachetools \
  haversine \
  psycopg2 \
  shapely \
 && conda remove -n python2 --quiet --yes --force qt pyqt \
 && conda clean -tipsy

ADD marblecutter /usr/local/src/marblecutter

RUN pip3 install mercantile https://github.com/mapbox/rasterio/archive/92d5e81.tar.gz \
  && pip3 install -e /usr/local/src/marblecutter

RUN pip2 install mercantile https://github.com/mapbox/rasterio/archive/92d5e81.tar.gz \
  && pip2 install -e /usr/local/src/marblecutter

USER $NB_USER

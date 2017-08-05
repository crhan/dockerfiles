from crhan/anaconda3
maintainer ruohan.chen <crhan123@gmail.com>

RUN conda create -n pyannote python=3.5 anaconda -y
RUN source activate pyannote; \
  conda install -c menpo cmake gcc ffmpeg=3.1.3 opencv boost -y
RUN source activate pyannote; \
  pip install pyannote-video

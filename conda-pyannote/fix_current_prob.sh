#!/usr/bin/env bash

source activate pyannote
git clone --depth 1 https://github.com/crhan/pyannote-video.git /opt/pyannote-video
cd /opt/pyannote-video
pip install -U setuptools
pip install -U .

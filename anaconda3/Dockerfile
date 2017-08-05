from krallin/centos-tini:7
maintainer ruohan.chen <crhan123@gmail.com>

RUN yum groupinstall 'Development Tools' -y
RUN curl https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh > ~/anaconda.sh && \
      /bin/bash ~/anaconda.sh -b -p /opt/conda && \
      rm ~/anaconda.sh

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
ENV PATH=/opt/conda/bin:$PATH

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

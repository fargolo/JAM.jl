# Steps are out of convention to opmitize precompiled partial images
# during the first steps of development.  
# Build it using $docker build --build-arg cmdstan_dir=$YOUR_PATH_TO_CMD_STAN$  Dockerfile
# if cmdstan is not in /usr/lib


FROM julia:1.0

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    vim \
    tmux \
    wget \
    unzip \
    cmake \
    git \
    locales-all \
    python3 \
    && apt-get clean 

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8


RUN apt-get install -y r-base
RUN R -e 'install.packages("loo",repos='http://cran.rstudio.com/')' 

COPY app /abu
COPY cmdstan /abu/cmdstan
WORKDIR /abu/cmdstan
#RUN make build

WORKDIR /abu
EXPOSE 8000
RUN julia deps.jl
RUN julia -i server.jl
# The server won`t work without repeating the command bellow using CMD  
# To speed startup, skip server deploy running with: 
# $sudo docker container run -it -p 8080:8000 container_name bash
# Which will replace command bellow
CMD julia -i server.jl
# A weird bug involving @async default configs for Mux  
# Please refer to https://discourse.julialang.org/t/keeping-julia-alive-while-running-a-web-server-in-the-background/8422/4  


# Alternative nasty (infinite loop; useless cycles) solution: $julia -e "include(\"server.jl\");while(true);sleep(1);end"  

FROM git-registry.lab.sspcloud.fr/funcamp-r/funcamp-r-dock as build  
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssl-dev libxml2-dev make pandoc zlib1g-dev pandoc-citeproc
ADD . /app
RUN cd /app && R CMD build .

FROM git-registry.lab.sspcloud.fr/funcamp-r/funcamp-r-dock
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssl-dev libxml2-dev make pandoc zlib1g-dev pandoc-citeproc
COPY --from=build /app/funcamp*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 3838
CMD  ["R", "-e", "funcampR::launch_learn(port=3838,host='0.0.0.0')"]

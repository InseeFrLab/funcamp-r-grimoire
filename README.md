<!-- badges: start -->
[![MIT](https://img.shields.io/badge/license-MIT-blue)](https://choosealicense.com/licenses/mit/)
<!-- badges: end -->

# General purpose

The goal of funcamp-r-grimoire is to deploy tutorials built as shiny_prerendered and shiny rmd that are gathered in a R package and/or docker. Each tutorial is presented as a chapter of a "grimoire", which the trainee opens during his quest in the Icarius game. The tutorial n°XX corresponds to the chapterXX.Rmd file. All the tutorials are grouped in a directory named `learnr` and stored in their `chapterXX` sub-directory. In addition, a `data` directory groups together the data files necessary to monitor the exercises. All source files are stored in sub-directories corresponding to the chapter concerned.

# Deploy using Docker

Use the base docker image as built in inseefrlab/funcamp-r-base:master, with all necessary packages included (especially, shiny, shinyAce, learnr, parsons).

## build the package

```{txt}
FROM inseefrlab/funcamp-r-base:master as build  
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssl-dev libxml2-dev make pandoc zlib1g-dev pandoc-citeproc
ADD . /app
RUN cd /app && R CMD build .
```

## Create a Dockerfile

```{txt}
FROM inseefrlab/funcamp-r-base:master
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libssl-dev libxml2-dev make pandoc zlib1g-dev pandoc-citeproc
COPY --from=build /app/funcamp*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 3838
CMD  ["R", "-e", "funcampR::launch_learn(port=3838,host='0.0.0.0')"]
```


## Launch docker image

```{txt}
docker run -p 80:3838 inseefrlab/funcamp-r-grimoire:master
```

## Launch a tutorial

Launch a random tutorial :

```
funcampR::launch_learn()
```

Launch tutorial n°XX :

```
funcampR::launch_learn(port=3838,host='0.0.0.0',file=funcampR:::tous_les_programmes('chapitreXX.Rmd'))
```

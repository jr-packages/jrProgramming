FROM jrpackages/jrnotes

ARG jr_pkg=jrProgramming

RUN install2.r -n -1 -d TRUE -l /rpackages/ --error $jr_pkg \
    && rm -rf /tmp/downloaded_packages/
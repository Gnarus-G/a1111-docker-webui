FROM rocm/pytorch AS base

WORKDIR /a1111
RUN chown -v 1000:1000 /a1111
RUN chmod -v g+w /a1111

FROM base AS deps

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN yes | apt install python3.11-full
RUN yes | apt install libtcmalloc-minimal4
RUN yes | apt install bc

ENV python_cmd="python3.11"

FROM deps

USER 1000:1000

CMD [ "./webui.sh" ]

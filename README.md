# Speech to text alignment service

This repository contains a speech-to-text alignment webservice for interview transcriptions. It is a small
wrapper around [speech2textalign](https://github.com/proycon/speech2textalign) tool which first uses whisper to transcribe speech to text, and then uses [stam align](https://annotation.github.io/stam) to align the transcription with the provided input text. The webservice layer is provided via [CLAM](https://proycon.github.io/clam/). 
This webservice is developed at the Centre of Language and Speech Technology, Radboud University, Nijmegen.

## Installation

For end-users and hosting partners, we provide a container image that ships with a web interface. 
You can pull a prebuilt image from the Docker Hub registry using docker as follows:

```
$ docker pull proycon/speech2textalignservice
```

Run the container as follows:

```
$ docker run -v /path/to/your/data:/data -p 8080:80 proycon/speech2textalignservice 
```

Assuming you run locally, the web interface can then be accessed on ``http://127.0.0.1:8080/``.

If you want to deploy this service on your own infrastructure, you will want to set some of the environment variables
defined in the `Dockerfile` when running the container, most notably the ones regarding authentication, as this is by
default disabled and as such *NOT* suitable for production deployments.

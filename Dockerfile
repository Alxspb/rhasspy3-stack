FROM ubuntu:22.04

RUN apt update && \
	apt install git python3

RUN git clone https://github.com/rhasspy/rhasspy3 && pushd rhasspy3

COPY configuration.yaml config/

RUN mkdir -p config/programs/vad/ && cp -R programs/vad/silero config/programs/vad/ && \
	./config/programs/vad/silero/script/setup
RUN mkdir -p config/programs/asr/ && cp -R programs/asr/faster-whisper config/programs/asr/ && \
	./config/programs/asr/faster-whisper/script/setup && \
	python config/programs/asr/faster-whisper/script/download.py tiny-int8
RUN mkdir -p config/programs/wake/ && cp -R programs/wake/porcupine1 config/programs/wake/ && \
	./config/programs/wake/porcupine1/script/setup && \
	python config/programs/wake/porcupine1/script/download.py
RUN mkdir -p config/programs/tts/ && cp -R programs/tts/piper config/programs/tts/ && \
	python config/programs/tts/piper/script/setup.py && \
	python config/programs/tts/piper/script/download.py english